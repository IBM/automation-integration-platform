###########################################################################################################################
# Name: Cloud Pak for Integration Terraform Variable File
# Desc: Initial input variables to support installation of Cloud Pak for Integration into the cloud provider of your choice
###########################################################################################################################

## rwo_storage_class: ReadWriteOnce access type Storage Class
rwo_storage_class="ibmc-vpc-block-10iops-tier"

## rwx_storage_class: ReadWriteMany access type Storage Class
rwx_storage_class="ocs-storagecluster-cephfs"

## gitops-repo_host: The host for the git repository.
gitops_repo_host="github.com"

## gitops-repo_type: The type of the hosted git repository (github or gitlab).
gitops_repo_type="github"

## gitops-repo_org: The org/group where the git repository exists/will be provisioned.
gitops_repo_org="cloud-native-toolkit-gj-ka"

## gitops-repo_repo: The short name of the repository (i.e. the part after the org/group name)
gitops_repo_repo="cp4i-in-tz-vpc-cluster"

## gitops-cluster-config_banner_text: The text that will appear in the top banner in the cluster
gitops-cluster-config_banner_text="Software Everywhere CP4Integration- VPC Cluster"



