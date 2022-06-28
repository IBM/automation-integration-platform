#!/bin/bash
# IBM GSI Ecosystem Lab
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

CLOUD_PROVIDER=""
STORAGE=""
PREFIX_NAME=""
STORAGEVENDOR=""


# Get the options
while getopts ":p:s:n:h:" o; do
   case "${o}" in
      h) # display Help
         Usage
         exit 1;;
      p)
         CLOUD_PROVIDER=$OPTARG;;
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


shift $((OPTIND-1))

if [ -z "${CLOUD_PROVIDER}" ] || [ -z "${STORAGE}" ]; then
    Usage
fi

SCRIPT_DIR=$(cd $(dirname $0); pwd -P)
WORKSPACES_DIR="${SCRIPT_DIR}/../workspaces"
WORKSPACE_DIR="${WORKSPACES_DIR}/current"
	@@ -63,15 +41,15 @@ echo "Setting up workspace in '${WORKSPACE_DIR}'"
echo "*****"


#cp "${SCRIPT_DIR}/terraform.tfvars.template" "${SCRIPT_DIR}/terraform.tfvars"
ln -s "${SCRIPT_DIR}/terraform.tfvars" ./terraform.tfvars

echo "Setting up workspace from '${TEMPLATE_FLAVOR}' template"
echo "*****"

WORKSPACE_DIR=$(cd "${WORKSPACE_DIR}"; pwd -P)

ALL_ARCH="200|210|215|220|230|240|250|260|260"

echo "Setting up automation  ${WORKSPACE_DIR}"