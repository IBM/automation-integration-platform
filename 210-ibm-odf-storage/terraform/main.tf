module "gitops_repo" {
  source = "github.com/cloud-native-toolkit/terraform-tools-gitops?ref=v1.22.2"

  branch = var.gitops_repo_branch
  debug = var.debug
  gitea_host = var.gitops_repo_gitea_host
  gitea_org = var.gitops_repo_gitea_org
  gitea_token = var.gitops_repo_gitea_token
  gitea_username = var.gitops_repo_gitea_username
  gitops_namespace = var.gitops_repo_gitops_namespace
  host = var.gitops_repo_host
  org = var.gitops_repo_org
  project = var.gitops_repo_project
  public = var.gitops_repo_public
  repo = var.gitops_repo_repo
  sealed_secrets_cert = var.gitops_repo_sealed_secrets_cert
  server_name = var.gitops_repo_server_name
  strict = var.gitops_repo_strict
  token = var.gitops_repo_token
  type = var.gitops_repo_type
  username = var.gitops_repo_username
}
module "gitops-ibm-odf" {
  source = "github.com/cloud-native-toolkit/terraform-gitops-ibm-odf?ref=v0.3.1"

  autoDiscoverDevices = var.gitops-ibm-odf_autoDiscoverDevices
  billingType = var.gitops-ibm-odf_billingType
  clusterEncryption = var.gitops-ibm-odf_clusterEncryption
  git_credentials = module.gitops_repo.git_credentials
  gitops_config = module.gitops_repo.gitops_config
  hpcsBaseUrl = var.gitops-ibm-odf_hpcsBaseUrl
  hpcsEncryption = var.gitops-ibm-odf_hpcsEncryption
  hpcsInstanceId = var.gitops-ibm-odf_hpcsInstanceId
  hpcsSecretName = var.gitops-ibm-odf_hpcsSecretName
  hpcsServiceName = var.gitops-ibm-odf_hpcsServiceName
  hpcsTokenUrl = var.gitops-ibm-odf_hpcsTokenUrl
  ibmcloud_api_key = var.ibmcloud_api_key
  kubeseal_cert = module.gitops_repo.sealed_secrets_cert
  monDevicePaths = var.gitops-ibm-odf_monDevicePaths
  monSize = var.gitops-ibm-odf_monSize
  monStorageClassName = var.gitops-ibm-odf_monStorageClassName
  namespace = module.odf_namespace.name
  numOfOsd = var.gitops-ibm-odf_numOfOsd
  ocsUpgrade = var.gitops-ibm-odf_ocsUpgrade
  osdDevicePaths = var.gitops-ibm-odf_osdDevicePaths
  osdSize = var.gitops-ibm-odf_osdSize
  osdStorageClassName = var.gitops-ibm-odf_osdStorageClassName
  server_name = module.gitops_repo.server_name
  workerNodes = var.gitops-ibm-odf_workerNodes
}
module "odf_namespace" {
  source = "github.com/cloud-native-toolkit/terraform-gitops-namespace?ref=v1.15.0"

  argocd_namespace = var.odf_namespace_argocd_namespace
  ci = var.odf_namespace_ci
  create_operator_group = var.odf_namespace_create_operator_group
  git_credentials = module.gitops_repo.git_credentials
  gitops_config = module.gitops_repo.gitops_config
  name = var.odf_namespace_name
  server_name = module.gitops_repo.server_name
}
module "util-clis" {
  source = "cloud-native-toolkit/clis/util"
  version = "1.18.1"

  bin_dir = var.util-clis_bin_dir
  clis = var.util-clis_clis == null ? null : jsondecode(var.util-clis_clis)
}
