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

Confirm_To_Proceed=""
SCRIPT_DIR=""
WORKSPACES_DIR=""
WORKSPACE_DIR=""
VALID_CLOUD_PROVIDERS=("ibm","aws","azure")
VALID_STORAGE_PROVIDERS=("odf","portworx")
STORAGE_CLASS_4_IBM_ODF=""

CLOUD_PROVIDER=""
STORAGE=""
PREFIX_NAME=""
RWO_STORAGE=""
RWX_STORAGE=""
REGION=""
PORTWORX_SPEC_FILE=""
PORTWORX_SPEC_CONTENT_IN_BASE64_ENCODED=""
DEFAULT_RWO_STORAGECLASS_IBM="ibmc-vpc-block-10iops-tier"
DEFAULT_RWO_STORAGECLASS_AWS="gp2"
DEFAULT_RWO_STORAGECLASS_AZURE="managed-premium"
GIT_HOST=""
BANNER=""
DEFAULT_BANNER="Cloud Pak for Integration"


RED='\033[0;31m'
NC='\033[0m' # No Color
GREEN='\033[0;32m'
PURPLE='\033[0;35m'
YELLOW='\033[33;5m'




Usage()
{
   
   echo
   echo "Usage: setup-workspace.sh"
   echo "  options:"
   echo "  -p     Cloud provider valid values (aws, azure, ibm)"
   echo "  -n     (optional) prefix that should be used for all variables"
   echo "  -b     (optional) the banner text that should be shown at the top of the cluster"
   echo "  -g     (optional) the git host that will be used for the gitops repo. If left blank gitea will be used by default. (Github, Github Enterprise, Gitlab, Bitbucket, Azure DevOps, and Gitea servers are supported)"
   echo "  -h     Print this help"
   echo
   echo "Creates a workspace folder and populates it with automation bundles you require."
}

Validate_Input_Param()
{

  if [ -z "$CLOUD_PROVIDER" ] ; then
    echo -e "${RED}Cloud Provider Can not be empty.${NC}"
    Usage
    exit 1
  fi

  if [[ ! ${VALID_CLOUD_PROVIDERS[*]} =~ ${CLOUD_PROVIDER} ]]; then
    echo -e "${RED} Invalid Cloud Provider.${NC} Valid Choice are (ibm/azure/aws)!!!!!!"
    Usage
    exit 1
  fi


}

Print_Input_Params()
{
  echo -e "${PURPLE}Validated Input Params are ${NC}"
  echo -e " ${GREEN} Cloud Provider        : $CLOUD_PROVIDER"
  echo -e " --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- "
  
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

  echo -e "${PURPLE}The following steps are crucial as the choice of CP4i Capabilities to be chosen for deployment ${NC}"
  echo "      1. PlatformNavigator(Mandatory & Must have)"
  echo "      2. IBM APIConnect"
  echo "      3. IBM MQ"
  echo "      4. IBM APP Connect Enterprise (Designer Tooling)"
  echo "      5. IBM EventStreams"
  echo "      6. IBM MQ Uniform Cluster"
  #echo "      7. ALL THE ABOVE"
  echo -e "${PURPLE}Let us start ....${NC}"

        Select_Individual_Capabilities "bom_280" 'ALL the listed capabilities instead of choosing 1-by-1'
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
      echo -e "${PURPLE}Choices being made.....${NC}"
      echo " "
      if [ ${bomIdMap["$bom_280"]} == 'y' ] ; then
        echo "       All - APIC/MQ/ES/ACE/PlatformNavigator : " ${bomIdMap["$bom_280"]}
      fi
      if [ ${bomIdMap["$bom_215"]} == 'y' ] ; then
        echo "       Platform Navigator                     : " ${bomIdMap["$bom_215"]}
      fi
      if [ ${bomIdMap["$bom_220"]} == 'y' ] ; then
        echo "       IBM API Connect                        : " ${bomIdMap["$bom_220"]}
      fi
      if [ ${bomIdMap["$bom_230"]} == 'y' ] ; then
        echo "       IBM MQ                                 : " ${bomIdMap["$bom_230"]}
      fi
      if [ ${bomIdMap["$bom_240"]} == 'y' ] ; then
        echo "       IBM App Connect Enterprise             : " ${bomIdMap["$bom_240"]}
      fi
      if [ ${bomIdMap["$bom_250"]} == 'y' ] ; then
        echo "       IBM EventStreams                       : " ${bomIdMap["$bom_250"]}
      fi
      if [ ${bomIdMap["$bom_260"]} == 'y' ] ; then
        echo "       IBM MQ Uniform Cluster                 : " ${bomIdMap["$bom_260"]}
      fi


  echo -e " ---------------------------------------------------------------------------------------------------- "
      
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


Install_RookNFS()
{
  SCRIPT_DIR=$(cd $(dirname $0); pwd -P)
  WORKSPACES_DIR="${SCRIPT_DIR}/../workspaces"
  RookNFS_WORKDIR="${WORKSPACES_DIR}/rook-nfs-workdir"

  mkdir -p "${RookNFS_WORKDIR}"

  #IMAGE_TO_FIND="rook/nfs:v1.7.3"
  export IMAGE_TO_REPLACE="icr.io/cpopen/cpd/rook-nfs:kz-220512"
  export PROVIDE_EXISTING_RWO_STORAGECLASS_NAME=""

  echo ">>>${SCRIPT_DIR} "
  echo ">>>${RookNFS_WORKDIR}"
    
  if [ $CLOUD_PROVIDER == 'ibm' ]  ; then
    PROVIDE_EXISTING_RWO_STORAGECLASS_NAME=$DEFAULT_RWO_STORAGECLASS_IBM
  elif [ $CLOUD_PROVIDER == 'aws' ]  ; then
    PROVIDE_EXISTING_RWO_STORAGECLASS_NAME=$DEFAULT_RWO_STORAGECLASS_AWS
  elif [ $CLOUD_PROVIDER == 'azure' ]  ; then
    PROVIDE_EXISTING_RWO_STORAGECLASS_NAME=$DEFAULT_RWO_STORAGECLASS_AZURE
  else
    echo "Invalid Cloud Provider.. Hence Exiting the process..."
    exit 0
  fi
  
  cp ${SCRIPT_DIR}/rook-nfs/* ${RookNFS_WORKDIR}
  
  cd "${RookNFS_WORKDIR}"
  
  yq -i '.spec.storageClassName=env(PROVIDE_EXISTING_RWO_STORAGECLASS_NAME)' nfs-pwx-claim_pvc.yaml
  
  #Remove the already cloned dir if exist
  rm -rf nfs

  git clone --single-branch --branch v1.7.3 https://github.com/rook/nfs.git 

  cd nfs/cluster/examples/kubernetes/nfs

  if ! oc login "${TF_VAR_server_url}" --token="${TF_VAR_cluster_login_token}" --insecure-skip-tls-verify=true 1> /dev/null; then
    echo -e "${RED} Error While Login to OCP to setup RookNFS server ${NC}"
    exit 1
  fi

  yq -i '.spec.template.spec.containers[].image=env(IMAGE_TO_REPLACE)' operator.yaml

  # #Apply the CustomResourceDefinitions to the cluster:
  oc apply -f crds.yaml

  # #Create the operator deployment:
  oc apply -f operator.yaml
  sleep 45

  # #Grant the Rook NFS service account access to the privileged SecurityContextConstraints (SCC) resources:
  oc adm policy add-scc-to-user privileged system:serviceaccount:rook-nfs:rook-nfs-server

  cd ${RookNFS_WORKDIR}
  #Create RBAC objects for the NFS server by applying the YAML to the cluster.
  oc apply -f rbac.yaml
  sleep 10

  # #Apply this YAML to create a PersistentVolumeClaim (PVC) for the NFS server. 
  # #Make sure the PVC size is large enough to support all future volumes requested from this server; a size of 200Gi is recommended. 
  # #You must replace the value of <rwo-storage-class> with the RWO storage class you intend to use.
  oc apply -f nfs-pwx-claim_pvc.yaml
  sleep 15

  oc apply -f NFSServer.yaml
  sleep 30

  # #Create a storageclass named 'integration-storage' which supports RWX (ReadWriteMany)
  oc apply -f rwx_integration-storage_class.yaml


  cd "${SCRIPT_DIR}"
   
}

Set_Valid_Storage_Class_for_RWO_and_RWX()
{

  if [[ "${CLOUD_PROVIDER}" == "aws" ]]; then
    RWO_STORAGE="gp2"
  elif [[ "${CLOUD_PROVIDER}" == "azure" ]]; then
    RWO_STORAGE="managed-premium"
  elif [[ "${CLOUD_PROVIDER}" == "ibm" ]] ; then
    RWO_STORAGE="ibmc-vpc-block-10iops-tier"
  else
    RWO_STORAGE="<your block storage on aws: gp2, on azure: managed-premium, on ibm: ibmc-vpc-block-10iops-tier>"
  fi


  RWX_STORAGE="integration-storage"

}

Check_Whether_Storage_Installed()
{

      if ! oc login "${TF_VAR_server_url}" --token="${TF_VAR_cluster_login_token}" --insecure-skip-tls-verify=true 1> /dev/null; then
        echo -e "${RED} Error While Login to OCP to check the StorageClass existance"
        exit 1
      fi
      
      if oc get storageclass "${RWX_STORAGE}" 1> /dev/null 2> /dev/null; then
        echo -e " ${GREEN} Found RWX StorageClass:${RWX_STORAGE} & RWO StorageClass:${RWO_STORAGE} .Will Skip storage layer...${NC}"
      else
          echo -e "${RED} RWX (ReadWriteMany) Storage class is missing. Hence Exiting the process... ${NC}"
          exit 0  
      fi

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
   
    #Cluster Module is Mandatory: 105-xxx
    if [[ $name == "105"* ]]; then
      Copy_Required_Module_In_CurrentWorkSpace $name $SCRIPT_DIR $WORKSPACE_DIR
    fi
   
    #GitOps Module is Mandatory: 200-xxx
    if [[ $name == "200"* ]]; then
      Copy_Required_Module_In_CurrentWorkSpace $name $SCRIPT_DIR $WORKSPACE_DIR
    fi


    #Choice of Storage Based on Provider: 210-xxx
    if [[ $name == "210-$CLOUD_PROVIDER-$STORAGE-storage" ]]; then
      #Just Ignore & Do nothing
      echo ""

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
  echo -e "${YELLOW}        Move to ${WORKSPACE_DIR} this is where your automation is configured ${NC}"
  

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
  ln -s "${WORKSPACE_DIR}"/cluster.tfvars ./cluster.tfvars
  ln -s "${WORKSPACE_DIR}"/gitops.tfvars ./gitops.tfvars
  cd - > /dev/null


}

# Get the options
while getopts ":p:h:g:b:n:" option; do
   case $option in
      h) # display Help
         Usage
         exit 1;;
      p)
         CLOUD_PROVIDER=${OPTARG};;
      n) # Enter a name
         PREFIX_NAME=$OPTARG;;
      g) # Enter a name
         GIT_HOST=$OPTARG;;
      b) # Enter a name
         BANNER=$OPTARG;;
     \?) # Invalid option
         echo "Error: Invalid option"
         Usage
         exit 1;;
   esac
done

#Validate the Input Parameters
Validate_Input_Param

#Print the Validated Input Params
Print_Input_Params


#This Function helps the user to choose the required capabilities
Select_CP4I_Capabilities

#This function helps in summarizing the choices being made
Summarize_the_Choice

#Help the get the confirmation on the choices being made
Get_Confirmation_To_Proceed

#Install Rook NFS Storage for supporting RWX. We automated the steps provided in 
#https://www.ibm.com/docs/en/cloud-paks/cp-integration/2022.2?topic=ui-deploying-platform-rwo-storage

echo -e "${PURPLE}Setting Up RookNFS Server...${NC}"
Install_RookNFS
echo -e "${Green}Setting Up RookNFS Server Completed Successfully!!! ${NC}"

#Set the appropriate StorageClass for RWO & RWX based on the Storage Provider
Set_Valid_Storage_Class_for_RWO_and_RWX

#Check Whether Portworx is already installed. If it already installed, then we need to have a logic to skip 210-xxx module
Check_Whether_Storage_Installed


SCRIPT_DIR=$(cd $(dirname $0); pwd -P)
WORKSPACES_DIR="${SCRIPT_DIR}/../workspaces"
WORKSPACE_DIR="${WORKSPACES_DIR}/current"

if [[ -d "${WORKSPACE_DIR}" ]]; then
  DATE=$(date "+%Y%m%d%H%M")
  mv "${WORKSPACE_DIR}" "${WORKSPACES_DIR}/workspace-${DATE}"
fi

echo "Setting up workspace in '${WORKSPACE_DIR}'"

mkdir -p "${WORKSPACE_DIR}"

cd "${WORKSPACE_DIR}"

# echo ">>>>>>SCRIPT_DIR>>>>>>>>>>>>>>>>>>" $SCRIPT_DIR
# echo ">>>>>>PREFIX_NAME>>>>>>>>>>>>>>>>>>" $PREFIX_NAME
# echo ">>>>>>RWX_STORAGE>>>>>>>>>>>>>>>>>>" $RWX_STORAGE
# echo ">>>>>>RWO_STORAGE>>>>>>>>>>>>>>>>>>" $RWO_STORAGE
# echo ">>>>>>PORTWORX_SPEC_FILE>>>>>>>>>>>>>>>>>>" $PORTWORX_SPEC_FILE
# #echo ">>>>>>PORTWORX_SPEC_CONTENT_IN_BASE64_ENCODED>>>>>>>>>>>>>>>>>>" $PORTWORX_SPEC_CONTENT_IN_BASE64_ENCODED
# echo ">>>>>>REGION>>>>>>>>>>>>>>>>>>" $REGION

if [[ -z "${GIT_HOST}" ]]; then
  GITHOST_COMMENT="#"
fi
if [[ -z "${BANNER}" ]]; then
  BANNER="${DEFAULT_BANNER}"
fi

cat "${SCRIPT_DIR}/terraform.tfvars.template-cluster" | \
  sed "s/TO_BE_REPLACED_BANNER/${BANNER}/g" | \
  sed "s/TO_BE_REPLACED_RWX_STORAGE/${RWX_STORAGE}/g" | \
  sed "s/TO_BE_REPLACED_RWO_STORAGE/${RWO_STORAGE}/g" | \
  sed "s/TO_BE_REPLACED_REGION/${REGION}/g" | \
  sed "s/PREFIX/${PREFIX_NAME}/g"  | \
  sed "s/TO_BE_REPLACED_CONTENT_OF_PORTWORX_SPEC_IN_BASE64_ENCODED/${PORTWORX_SPEC_CONTENT_IN_BASE64_ENCODED}/g"  \
  > "${WORKSPACE_DIR}/cluster.tfvars"

if [[ ! -f "${WORKSPACE_DIR}/gitops.tfvars" ]]; then
  cat "${SCRIPT_DIR}/terraform.tfvars.template-gitops" | \
    sed -E "s/#(.*=\"GIT_HOST\")/${GITHOST_COMMENT}\1/g" | \
    sed "s/PREFIX/${PREFIX_NAME}/g"  | \
    sed "s/GIT_HOST/${GIT_HOST}/g" \
    > "${WORKSPACE_DIR}/gitops.tfvars"
fi



ln -s "${SCRIPT_DIR}/cluster.tfvars" ./cluster.tfvars
ln -s "${SCRIPT_DIR}/gitops.tfvars" ./gitops.tfvars

cp "${SCRIPT_DIR}/apply-all.sh" "${WORKSPACE_DIR}/apply-all.sh"
cp "${SCRIPT_DIR}/destroy-all.sh" "${WORKSPACE_DIR}/destroy-all.sh"
cp "${SCRIPT_DIR}/credentials.properties" "${WORKSPACE_DIR}/credentials.properties"
cp "${SCRIPT_DIR}/terragrunt.hcl" "${WORKSPACE_DIR}/terragrunt.hcl"
cp "${SCRIPT_DIR}/layers.yaml" "${WORKSPACE_DIR}/layers.yaml"
cp -R "${SCRIPT_DIR}/.mocks" "${WORKSPACE_DIR}/.mocks"


WORKSPACE_DIR=$(cd "${WORKSPACE_DIR}"; pwd -P)



#This function helps in Pick the required terraform templates and copy to current workdirectory
# Pls note If Portworks is alreally installed, then we need to skip the storage
Pick_Required_Modules



