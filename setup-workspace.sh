#!/bin/bash

# IBM GSI Ecosystem Lab
bom_215=0 bom_220=1 bom_230=2 bom_240=3 bom_250=4 bom_260=5 bom_280=6
declare -a bomIdMap
bomIdMap=(
    ["bom_215"]="y"
    ["bom_220"]="n"
    ["bom_230"]="n"
    ["bom_240"]="n"
    ["bom_250"]="n"
    ["bom_260"]="n"
    ["bom_280"]="n"
    )
CLOUD_PROVIDER=""
STORAGE=""
PREFIX_NAME=""
Confirm_To_Proceed=""
SCRIPT_DIR=""
WORKSPACES_DIR=""
WORKSPACE_DIR=""
VALID_CLOUD_PROVIDERS=("ibm","aws","azure")
VALID_STORAGE_PROVIDERS=("odf","portworx")

RWO_STORAGE=""
RWX_STORAGE=""
PORTWORX_SPEC_FILE=""



Usage()
{
   echo "Creates a workspace folder and populates it with automation bundles you require."
   echo
   echo "Usage: setup-workspace.sh"
   echo "  options:"
   echo "  -p     Cloud provider (aws, azure, ibm)"
   echo "  -s     Storage (portworx or odf)"
   echo "  -n     (optional) prefix that should be used for all variables"
   echo "  -h     Print this help"
   echo
}

Validate_Input_Param()
{
  if [ -z "$CLOUD_PROVIDER" ] || [ -z "$STORAGE" ]; then
    echo "Both Storage Provider or Cloud Provider Can not be empty."
    Usage
    exit 1
  fi

  if [[ ! ${VALID_CLOUD_PROVIDERS[*]} =~ ${CLOUD_PROVIDER} ]]; then
    echo "Invalid Cloud Provider. Valid Choice are (ibm/azure/aws)!!!!!!"
    Usage
    exit 1
  fi

  if [[ ! ${VALID_STORAGE_PROVIDERS[*]} =~ ${STORAGE} ]]; then
    echo "Invalid Storage Provider. Valid Choice are (odf/portworx)!!!!!!"
    Usage
    exit 1
  fi


}

Select_Individual_Capabilities()
{

    local choice
    individual_choice="not_completed"
    while 
      if [ $individual_choice == 'completed' ]; then
        return
      fi

    do 
      echo -n "Do you want to choose $2? "
      read -p "[y/n] " choice
      
      
      if [ $choice != 'y' ] && [ $choice != 'n' ]; then
        echo "Invalid option!!!"
      else
        individual_choice='completed'
        if [ $choice == 'y' ]; then
          #echo "Setting "$1 "to y"
          bomIdMap["${1}"]='y'
          #echo ">>>>>>Map " ${bomIdMap["${1}"]}
        else
          #echo "Setting "$1 "to n"
          bomIdMap["${1}"]='n'
          #echo ">>>>>>Map" ${bomIdMap["${1}"]}
        fi
      fi
    done  

}

Select_CP4I_Capabilities()
{

  echo "The following steps are crucial as the choice of CP4i Capabilities to be chosen for deployment"
  echo "      1. PlatformNavigator(Mandatory & Must have)"
  echo "      2. IBM APIConnect"
  echo "      3. IBM MQ"
  echo "      4. IBM APP Connect Enterprise (Designer Tooling)"
  echo "      5. IBM EventStreams"
  echo "      6. IBM MQ Uniform Cluster"
  echo "      7. ALL THE ABOVE"
  echo "Let us start ...."

        Select_Individual_Capabilities "bom_280" 'ALL the Above Capabilities'
        #If the 280 is chosen, then no need to check for individual capabilities
        if [ ${bomIdMap["bom_280"]} == 'y' ]; then
          Set_Others_To_No
          return
        fi
        Select_Individual_Capabilities "bom_220" 'IBM APIConnect'
        Select_Individual_Capabilities "bom_230" 'IBM MQ'
        Select_Individual_Capabilities "bom_240" 'IBM App Connect Enterprise'
        Select_Individual_Capabilities "bom_250" 'IBM EventStreams'
        Select_Individual_Capabilities "bom_260" 'IBM MQ Uniform Cluster'
}

Set_Others_To_No()
{
  #If 280 BOM Id is Selected, Then set others to 'n'
  bomIdMap["bom_215"]='n'
  bomIdMap["bom_220"]='n'
  bomIdMap["bom_230"]='n'
  bomIdMap["bom_240"]='n'
  bomIdMap["bom_250"]='n'
  bomIdMap["bom_260"]='n'
  bomIdMap["bom_220"]='n'

}

Summarize_the_Choice()
{
      echo " "
      echo "Choices being made....."
      echo " "
      echo "      1. All - APIC/MQ/ES/ACE/PlatformNavigator : " ${bomIdMap["$bom_280"]}
      echo "      2. Platform Navigator                     : " ${bomIdMap["$bom_215"]}
      echo "      3. IBM API Connect                        : " ${bomIdMap["$bom_220"]}
      echo "      4. IBM MQ                                 : " ${bomIdMap["$bom_230"]}
      echo "      5. IBM App Connect Enterprise             : " ${bomIdMap["$bom_240"]}
      echo "      6. IBM EventStreams                       : " ${bomIdMap["$bom_250"]}
      echo "      7. BM MQ Uniform Cluster                  : " ${bomIdMap["$bom_260"]}

      echo "      CLOUD_PROVIDER                             : "$CLOUD_PROVIDER
      echo "      STORAGE                                    : "$STORAGE
}

Get_Confirmation_To_Proceed()
{
    confirmation="not_completed"

    while 
      if [ $confirmation == 'completed' ]; then
        return
      fi

    do 
      echo -n "Confirm to Proceed "
      read -p "[y/n] ?" Confirm_To_Proceed
      
      
      if [ $Confirm_To_Proceed != 'y' ] && [ $Confirm_To_Proceed != 'n' ]; then
        echo "Invalid option!!!"
      else
        confirmation='completed'
        if [ $Confirm_To_Proceed == 'y' ]; then
          return
        else
          echo "Exiting the process..."
          exit 0
        fi
      fi      
    done  
}

Pick_Required_Modules()
{
  echo "Setting up automation  ${WORKSPACE_DIR}"

  echo ${SCRIPT_DIR}
  find ${SCRIPT_DIR}/. -type d -maxdepth 1 | grep -vE "[.][.]/[.].*" | grep -v workspace | sort | \
    while read dir;
  do
    name=$(echo "$dir" | sed -E "s/.*\///")

    if [[ ! -d "${SCRIPT_DIR}/${name}/terraform" ]]; then
      continue
    fi  
   
    #GitOps Module is Mandatory: 200-xxx
    if [[ $name == "200"* ]]; then
      Copy_Required_Module_In_CurrentWorkSpace $name $SCRIPT_DIR $WORKSPACE_DIR
      
    fi
    if [[ "${PORTWORX_SPEC_FILE}" == "installed" ]]; then
      # Ignore 210 Module and continue
      continue
    else 
      #Choice of Storage Based on Provider: 210-xxx
      if [[ $name == "210-$CLOUD_PROVIDER-$STORAGE-storage" ]]; then
          Copy_Required_Module_In_CurrentWorkSpace $name $SCRIPT_DIR $WORKSPACE_DIR
      fi  
    fi

    #Choice of CP4I Capabilities based on the user choice
    if [ ${bomIdMap["bom_280"]} == 'y'  ]; then
      if [[ $name == "280"* ]]; then
        Copy_Required_Module_In_CurrentWorkSpace $name $SCRIPT_DIR $WORKSPACE_DIR
        return
      fi
    else  
      if [[ $name != "200"*  && $name != "210"* && $name != "280"*  ]]; then
      #Get the first 3 character of the modulename
      module_to_be_picked="bom_"${name:0:3}
      #echo $module_to_be_picked
        if [ ${bomIdMap["$module_to_be_picked"]} == 'y'  ]; then
          Copy_Required_Module_In_CurrentWorkSpace $name $SCRIPT_DIR $WORKSPACE_DIR
        fi
      fi
    fi
    
  done
  echo "move to ${WORKSPACE_DIR} this is where your automation is configured"
}

Copy_Required_Module_In_CurrentWorkSpace()
{
  name=$1
  SCRIPT_DIR=$2
  WORKSPACE_DIR=$3

  echo "Setting up current/${name} from ${name}"
  mkdir -p ${name}
  cd "${name}"
  cp -R "${SCRIPT_DIR}/${name}/terraform/"* .
  cp "${SCRIPT_DIR}/${name}/bom.yaml" .
  cp "${SCRIPT_DIR}/${name}/destroy.sh" .
  ln -s "${WORKSPACE_DIR}"/terraform.tfvars ./terraform.tfvars
  cd - > /dev/null


}

Set_Valid_Storage_Class_for_RWO_and_RWX()
{

  if [[ "${CLOUD_PROVIDER}" == "aws" ]]; then
    RWO_STORAGE="gp2"
  elif [[ "${CLOUD_PROVIDER}" == "azure" ]]; then
    RWO_STORAGE="managed-premium"
  elif [[ "${CLOUD_PROVIDER}" == "ibm" ]] || [[ "${CLOUD_PROVIDER}" == "ibmcloud" ]]; then
    RWO_STORAGE="ibmc-vpc-block-10iops-tier"
  else
    RWO_STORAGE="<your block storage on aws: gp2, on azure: managed-premium, on ibm: ibmc-vpc-block-10iops-tier>"
  fi


  if [[ "${STORAGE}" == "portworx" ]]; then
    RWX_STORAGE="portworx-rwx-gp3-sc"
  elif [[ "${STORAGE}" == "odf" ]]; then
    RWX_STORAGE="ocs-storagecluster-cephfs"
  else
    RWX_STORAGE="<read-write-many storage class (e.g. portworx: portworx-rwx-gp3-sc or odf: ocs-storagecluster-cephfs)>"
  fi

}

Validate_Px_Spec_File()
{

  if [[ "${CLOUD_PROVIDER}" =~ aws|azure ]] && [[ -z "${PORTWORX_SPEC_FILE}" ]]; then
    if command -v oc 1> /dev/null 2> /dev/null; then
      echo "Looking for existing portworx storage class: ${RWX_STORAGE}"

      if ! oc login "${TF_VAR_server_url}" --token="${TF_VAR_cluster_login_token}" --insecure-skip-tls-verify=true 1> /dev/null; then
        exit 1
      fi

      if oc get storageclass "${RWX_STORAGE}" 1> /dev/null 2> /dev/null; then
        echo "  Found existing portworx installation. Skipping storage layer..."
        echo ""
        PORTWORX_SPEC_FILE="installed"
      fi
    fi

    if [[ -z "${PORTWORX_SPEC_FILE}" ]]; then
      DEFAULT_FILE=$(find . -name "portworx*.yaml" -maxdepth 1 -exec basename {} \; | head -1)

      while [[ -z "${PORTWORX_SPEC_FILE}" ]]; do
        echo -n "Provide the Portworx config spec file name: [${DEFAULT_FILE}] "
        read -r PORTWORX_SPEC_FILE

        if [[ -z "${PORTWORX_SPEC_FILE}" ]] && [[ -n "${DEFAULT_FILE}" ]]; then
          PORTWORX_SPEC_FILE="${DEFAULT_FILE}"
        fi
      done

      echo ""
    fi
  elif [[ "${CLOUD_PROVIDER}" == "ibm" ]]; then
    PORTWORX_SPEC_FILE=""
  fi

  if [[ -n "${PORTWORX_SPEC_FILE}" ]] && [[ "${PORTWORX_SPEC_FILE}" != "installed" ]] && [[ ! -f "${PORTWORX_SPEC_FILE}" ]]; then
    echo "Portworx spec file not found: ${PORTWORX_SPEC_FILE}" >&2
    exit 1
  fi

}

# Get the options
while getopts ":p:s:n:h:" option; do
   case $option in
      h) # display Help
         Usage
         exit 1;;
      p)
         CLOUD_PROVIDER=${OPTARG};;
      s) # Enter a name
         STORAGE=$OPTARG;;
      n) # Enter a name
         PREFIX_NAME=$OPTARG;;
     \?) # Invalid option
         echo "Error: Invalid option"
         Usage
         exit 1;;
   esac
done

#Validate the Input Parameters
Validate_Input_Param


#This Function helps the user to choose the required capabilities
Select_CP4I_Capabilities

#This function helps in summarizing the choices being made
Summarize_the_Choice

#Help the get the confirmation on the choices being made
Get_Confirmation_To_Proceed

#Set the appropriate StorageClass for RWO & RWX based on the Storage Provider
Set_Valid_Storage_Class_for_RWO_and_RWX

#In case of aws & azure, We need to validate Portworx Specfile existence
Validate_Px_Spec_File



SCRIPT_DIR=$(cd $(dirname $0); pwd -P)
WORKSPACES_DIR="${SCRIPT_DIR}/../workspaces"
WORKSPACE_DIR="${WORKSPACES_DIR}/current"

if [[ -d "${WORKSPACE_DIR}" ]]; then
  DATE=$(date "+%Y%m%d%H%M")
  mv "${WORKSPACE_DIR}" "${WORKSPACES_DIR}/workspace-${DATE}"
fi

echo "Setting up workspace in '${WORKSPACE_DIR}'"

mkdir -p "${WORKSPACE_DIR}"

PORTWORX_SPEC_FILE_BASENAME=$(basename "${PORTWORX_SPEC_FILE}")

if [[ -n "${PORTWORX_SPEC_FILE}" ]] && [[ "${PORTWORX_SPEC_FILE}" != "installed" ]]; then
  cp "${PORTWORX_SPEC_FILE}" "${WORKSPACE_DIR}/${PORTWORX_SPEC_FILE_BASENAME}"
fi


cd "${WORKSPACE_DIR}"


cat "${SCRIPT_DIR}/terraform.tfvars.template" | \
  sed "s/TO_BE_REPLACED_PREFIX/${PREFIX_NAME}/g" | \
  sed "s/TO_BE_REPLACED_RWX_STORAGE/${RWX_STORAGE}/g" | \
  sed "s/TO_BE_REPLACED_RWO_STORAGE/${RWO_STORAGE}/g" | \
  sed "s/TO_BE_REPLACE_PORTWORX_SPEC_FILE/${PORTWORX_SPEC_FILE_BASENAME}/g" \
  > "${SCRIPT_DIR}/terraform.tfvars"





ln -s "${SCRIPT_DIR}/terraform.tfvars" ./terraform.tfvars

cp "${SCRIPT_DIR}/apply-all.sh" "${WORKSPACE_DIR}/apply-all.sh"
cp "${SCRIPT_DIR}/destroy-all.sh" "${WORKSPACE_DIR}/destroy-all.sh"


WORKSPACE_DIR=$(cd "${WORKSPACE_DIR}"; pwd -P)



#This function helps in Pick the required terraform templates and copy to current workdirectory
# Pls note If Portworks is alreally installed, then we need to skip the storage
Pick_Required_Modules



