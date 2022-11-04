variable "ibmcloud_api_key" {
  type = string
  description = "The api key for IBM Cloud access"
}
variable "gitops-ibm-odf_osdStorageClassName" {
  type = string
  description = "Storage class that you want to use for your OSD devices"
  default = "ibmc-vpc-block-metro-10iops-tier"
}
variable "gitops-ibm-odf_osdDevicePaths" {
  type = string
  description = "Please provide IDs of the disks to be used for OSD pods if using local disks or standard classic cluster"
  default = ""
}
variable "gitops-ibm-odf_osdSize" {
  type = string
  description = "Size of your storage devices. The total storage capacity of your ODF cluster is equivalent to the osdSize x 3 divided by the numOfOsd."
  default = "250Gi"
}
variable "gitops-ibm-odf_numOfOsd" {
  type = string
  description = "Number object storage daemons (OSDs) that you want to create. ODF creates three times the numOfOsd value."
  default = "1"
}
variable "gitops-ibm-odf_billingType" {
  type = string
  description = "Billing Type for your ODF deployment (`essentials` or `advanced`)."
  default = "advanced"
}
variable "gitops-ibm-odf_ocsUpgrade" {
  type = string
  description = "Whether to upgrade the major version of your ODF deployment."
  default = "false"
}
variable "gitops-ibm-odf_clusterEncryption" {
  type = string
  description = "Enable encryption of storage cluster"
  default = "false"
}
variable "gitops-ibm-odf_workerNodes" {
  type = string
  description = "Install on which worker nodes"
  default = "all"
}
variable "gitops-ibm-odf_monSize" {
  type = string
  description = "Size of the storage devices that you want to provision for the monitor pods. The devices must be at least 20Gi each"
  default = "20Gi"
}
variable "gitops-ibm-odf_monStorageClassName" {
  type = string
  description = "Storage class to use for your Monitor pods. For VPC clusters you must specify a block storage class"
  default = "ibmc-vpc-block-metro-10iops-tier"
}
variable "gitops-ibm-odf_monDevicePaths" {
  type = string
  description = "Please provide IDs of the disks to be used for mon pods if using local disks or standard classic cluster"
  default = ""
}
variable "gitops-ibm-odf_autoDiscoverDevices" {
  type = string
  description = "Auto Discover Devices"
  default = "false"
}
variable "gitops-ibm-odf_hpcsEncryption" {
  type = string
  description = "Use Hyper Protect Crypto Services"
  default = "false"
}
variable "gitops-ibm-odf_hpcsServiceName" {
  type = string
  description = "Enter the name of your Hyper Protect Crypto Services instance. For example: Hyper-Protect-Crypto-Services-eugb"
  default = "false"
}
variable "gitops-ibm-odf_hpcsInstanceId" {
  type = string
  description = "Enter your Hyper Protect Crypto Services instance ID. For example: d11a1a43-aa0a-40a3-aaa9-5aaa63147aaa"
  default = "false"
}
variable "gitops-ibm-odf_hpcsSecretName" {
  type = string
  description = "Enter the name of the secret that you created by using your Hyper Protect Crypto Services credentials. For example: ibm-hpcs-secret"
  default = "false"
}
variable "gitops-ibm-odf_hpcsBaseUrl" {
  type = string
  description = "Enter the public endpoint of your Hyper Protect Crypto Services instance. For example: https://api.eu-gb.hs-crypto.cloud.ibm.com:8389"
  default = "false"
}
variable "gitops-ibm-odf_hpcsTokenUrl" {
  type = string
  description = "Enter https://iam.cloud.ibm.com/oidc/token"
  default = "false"
}
variable "odf_namespace_name" {
  type = string
  description = "The value that should be used for the namespace"
  default = "odf"
}
variable "odf_namespace_ci" {
  type = bool
  description = "Flag indicating that this namespace will be used for development (e.g. configmaps and secrets)"
  default = false
}
variable "odf_namespace_create_operator_group" {
  type = bool
  description = "Flag indicating that an operator group should be created in the namespace"
  default = true
}
variable "odf_namespace_argocd_namespace" {
  type = string
  description = "The namespace where argocd has been deployed"
  default = "openshift-gitops"
}
variable "gitops_repo_host" {
  type = string
  description = "The host for the git repository. The git host used can be a GitHub, GitHub Enterprise, Gitlab, Bitbucket, Gitea or Azure DevOps server. If the host is null assumes in-cluster Gitea instance will be used."
  default = ""
}
variable "gitops_repo_type" {
  type = string
  description = "[Deprecated] The type of the hosted git repository."
  default = ""
}
variable "gitops_repo_org" {
  type = string
  description = "The org/group where the git repository exists/will be provisioned. If the value is left blank then the username org will be used."
  default = ""
}
variable "gitops_repo_project" {
  type = string
  description = "The project that will be used for the git repo. (Primarily used for Azure DevOps repos)"
  default = ""
}
variable "gitops_repo_username" {
  type = string
  description = "The username of the user with access to the repository"
  default = ""
}
variable "gitops_repo_token" {
  type = string
  description = "The personal access token used to access the repository"
  default = ""
}
variable "gitops_repo_gitea_host" {
  type = string
  description = "The host for the default gitea repository."
  default = ""
}
variable "gitops_repo_gitea_org" {
  type = string
  description = "The org/group for the default gitea repository. If not provided, the value will default to the username org"
  default = ""
}
variable "gitops_repo_gitea_username" {
  type = string
  description = "The username of the default gitea repository"
  default = ""
}
variable "gitops_repo_gitea_token" {
  type = string
  description = "The personal access token used to access the repository"
  default = ""
}
variable "gitops_repo_repo" {
  type = string
  description = "The short name of the repository (i.e. the part after the org/group name)"
}
variable "gitops_repo_branch" {
  type = string
  description = "The name of the branch that will be used. If the repo already exists (provision=false) then it is assumed this branch already exists as well"
  default = "main"
}
variable "gitops_repo_public" {
  type = bool
  description = "Flag indicating that the repo should be public or private"
  default = false
}
variable "gitops_repo_gitops_namespace" {
  type = string
  description = "The namespace where ArgoCD is running in the cluster"
  default = "openshift-gitops"
}
variable "gitops_repo_server_name" {
  type = string
  description = "The name of the cluster that will be configured via gitops. This is used to separate the config by cluster"
  default = "default"
}
variable "gitops_repo_sealed_secrets_cert" {
  type = string
  description = "The certificate/public key used to encrypt the sealed secrets"
  default = ""
}
variable "gitops_repo_strict" {
  type = bool
  description = "Flag indicating that an error should be thrown if the repo already exists"
  default = false
}
variable "debug" {
  type = bool
  description = "Flag indicating that debug loggging should be enabled"
  default = false
}
variable "util-clis_bin_dir" {
  type = string
  description = "The directory where the clis should be downloaded. If not provided will default to ./bin"
  default = ""
}
variable "util-clis_clis" {
  type = string
  description = "The list of clis that should be made available in the bin directory. Supported values are yq, jq, igc, helm, argocd, rosa, gh, glab, and kubeseal. (If not provided the list will default to yq, jq, and igc)"
  default = "[\"yq\",\"jq\",\"igc\"]"
}
