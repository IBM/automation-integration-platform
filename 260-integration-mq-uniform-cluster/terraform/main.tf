module "cluster" {
  source = "github.com/cloud-native-toolkit/terraform-ocp-login?ref=v1.2.12"

  cluster_version = var.cluster_cluster_version
  ingress_subdomain = var.cluster_ingress_subdomain
  login_password = var.cluster_login_password
  login_token = var.cluster_login_token
  login_user = var.cluster_login_user
  server_url = var.server_url
  skip = var.cluster_skip
  tls_secret_name = var.cluster_tls_secret_name
}
module "cp4i-dependency-management" {
  source = "github.com/cloud-native-toolkit/terraform-cp4i-dependency-management?ref=v1.2.4"

  cp4i_version = var.cp4i-dependency-management_cp4i_version
}
module "cp4i-mq-cluster" {
  source = "github.com/cloud-native-toolkit/terraform-gitops-namespace?ref=v1.11.2"

  argocd_namespace = var.cp4i-mq-cluster_argocd_namespace
  ci = var.cp4i-mq-cluster_ci
  create_operator_group = var.cp4i-mq-cluster_create_operator_group
  git_credentials = module.gitops_repo.git_credentials
  gitops_config = module.gitops_repo.gitops_config
  name = var.cp4i-mq-cluster_name
  server_name = module.gitops_repo.server_name
}
module "gitops_repo" {
  source = "github.com/cloud-native-toolkit/terraform-tools-gitops?ref=v1.16.0"

  branch = var.gitops_repo_branch
  gitops_namespace = var.gitops_repo_gitops_namespace
  host = var.gitops_repo_host
  org = var.gitops_repo_org
  public = var.gitops_repo_public
  repo = var.gitops_repo_repo
  sealed_secrets_cert = module.sealed-secret-cert.cert
  server_name = var.gitops_repo_server_name
  strict = var.gitops_repo_strict
  token = var.gitops_repo_token
  type = var.gitops_repo_type
  username = var.gitops_repo_username
}
module "gitops-cp-catalogs" {
  source = "github.com/cloud-native-toolkit/terraform-gitops-cp-catalogs?ref=v1.2.1"

  entitlement_key = var.entitlement_key
  git_credentials = module.gitops_repo.git_credentials
  gitops_config = module.gitops_repo.gitops_config
  kubeseal_cert = module.gitops_repo.sealed_secrets_cert
  namespace = var.gitops-cp-catalogs_namespace
  server_name = module.gitops_repo.server_name
}
module "gitops-cp-mq" {
  source = "github.com/cloud-native-toolkit/terraform-gitops-cp-mq?ref=v1.1.5"

  catalog = module.gitops-cp-catalogs.catalog_ibmoperators
  catalog_namespace = var.gitops-cp-mq_catalog_namespace
  channel = module.cp4i-dependency-management.mq.channel
  git_credentials = module.gitops_repo.git_credentials
  gitops_config = module.gitops_repo.gitops_config
  namespace = var.gitops-cp-mq_namespace
  server_name = module.gitops_repo.server_name
}
module "gitops-cp-mq-uniform-cluster" {
  source = "github.com/cloud-native-toolkit/terraform-gitops-cp-mq-uniform-cluster?ref=v1.0.3"

  entitlement_key = module.gitops-cp-catalogs.entitlement_key
  git_credentials = module.gitops_repo.git_credentials
  gitops_config = module.gitops_repo.gitops_config
  ini_configmap = var.gitops-cp-mq-uniform-cluster_ini_configmap
  kubeseal_cert = module.gitops_repo.sealed_secrets_cert
  license = module.cp4i-dependency-management.mq.license
  license_use = module.cp4i-dependency-management.mq.license_use
  MQ_AvailabilityType = var.gitops-cp-mq-uniform-cluster_MQ_AvailabilityType
  mq_version = module.cp4i-dependency-management.mq.version
  mqsc_configmap = var.gitops-cp-mq-uniform-cluster_mqsc_configmap
  namespace = module.cp4i-mq-cluster.name
  server_name = module.gitops_repo.server_name
  storageClass = var.rwo_storage_class
}
module "olm" {
  source = "github.com/cloud-native-toolkit/terraform-k8s-olm?ref=v1.3.2"

  cluster_config_file = module.cluster.config_file_path
  cluster_type = module.cluster.platform.type_code
  cluster_version = module.cluster.platform.version
}
module "sealed-secret-cert" {
  source = "github.com/cloud-native-toolkit/terraform-util-sealed-secret-cert?ref=v1.0.1"

  cert = var.sealed-secret-cert_cert
  cert_file = var.sealed-secret-cert_cert_file
  private_key = var.sealed-secret-cert_private_key
  private_key_file = var.sealed-secret-cert_private_key_file
}
