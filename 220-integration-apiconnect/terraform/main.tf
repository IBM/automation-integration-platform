module "cluster" {
  source = "github.com/cloud-native-toolkit/terraform-ocp-login?ref=v1.6.0"

  ca_cert = var.cluster_ca_cert
  ca_cert_file = var.cluster_ca_cert_file
  cluster_version = var.cluster_cluster_version
  ingress_subdomain = var.cluster_ingress_subdomain
  login_password = var.cluster_login_password
  login_token = var.cluster_login_token
  login_user = var.cluster_login_user
  server_url = var.server_url
  skip = var.cluster_skip
  tls_secret_name = var.cluster_tls_secret_name
}
module "cp4i-apic" {
  source = "github.com/cloud-native-toolkit/terraform-gitops-namespace?ref=v1.15.0"

  argocd_namespace = var.cp4i-apic_argocd_namespace
  ci = var.cp4i-apic_ci
  create_operator_group = var.cp4i-apic_create_operator_group
  git_credentials = module.gitops_repo.git_credentials
  gitops_config = module.gitops_repo.gitops_config
  name = var.cp4i-apic_name
  server_name = module.gitops_repo.server_name
}
module "cp4i-version-dependency" {
  source = "github.com/cloud-native-toolkit/terraform-cp4i-dependency-management?ref=v1.2.7"

  cp4i_version = var.cp4i-version-dependency_cp4i_version
}
module "gitea" {
  source = "github.com/cloud-native-toolkit/terraform-tools-gitea?ref=v0.5.0"

  ca_cert = module.cluster.ca_cert
  ca_cert_file = var.gitea_ca_cert_file
  cluster_config_file = module.cluster.config_file_path
  cluster_type = module.cluster.platform.type_code
  instance_name = var.gitea_instance_name
  instance_namespace = module.gitea_namespace.name
  olm_namespace = module.olm.olm_namespace
  operator_namespace = module.olm.target_namespace
  password = var.gitea_password
  username = var.gitea_username
}
module "gitea_namespace" {
  source = "github.com/cloud-native-toolkit/terraform-k8s-namespace?ref=v3.2.4"

  cluster_config_file_path = module.cluster.config_file_path
  create_operator_group = var.gitea_namespace_create_operator_group
  name = var.gitea_namespace_name
}
module "gitops_repo" {
  source = "github.com/cloud-native-toolkit/terraform-tools-gitops?ref=v1.22.2"

  branch = var.gitops_repo_branch
  debug = var.debug
  gitea_host = module.gitea.host
  gitea_org = module.gitea.org
  gitea_token = module.gitea.token
  gitea_username = module.gitea.username
  gitops_namespace = var.gitops_repo_gitops_namespace
  host = var.gitops_repo_host
  org = var.gitops_repo_org
  project = var.gitops_repo_project
  public = var.gitops_repo_public
  repo = var.gitops_repo_repo
  sealed_secrets_cert = module.sealed-secret-cert.cert
  server_name = var.gitops_repo_server_name
  strict = var.gitops_repo_strict
  token = var.gitops_repo_token
  type = var.gitops_repo_type
  username = var.gitops_repo_username
}
module "gitops-cp-apic" {
  source = "github.com/cloud-native-toolkit/terraform-gitops-cp-apic?ref=v0.0.3"

  apic_version = module.cp4i-version-dependency.apic.version
  catalog = var.gitops-cp-apic_catalog
  catalog_namespace = var.gitops-cp-apic_catalog_namespace
  entitlement_key = var.entitlement_key
  git_credentials = module.gitops_repo.git_credentials
  gitops_config = module.gitops_repo.gitops_config
  kubeseal_cert = module.gitops_repo.sealed_secrets_cert
  license_id = module.cp4i-version-dependency.apic.license
  namespace = module.cp4i-apic.name
  profile = var.gitops-cp-apic_profile
  server_name = module.gitops_repo.server_name
  storage_class = var.rwo_storage_class
  usage = module.cp4i-version-dependency.apic.license_use
}
module "gitops-cp-apic-operator" {
  source = "github.com/cloud-native-toolkit/terraform-gitops-cp-apic-operator?ref=v1.2.7"

  catalog = module.gitops-cp-catalogs.catalog_ibmoperators
  catalog_namespace = var.gitops-cp-apic-operator_catalog_namespace
  channel = module.cp4i-version-dependency.apic.channel
  git_credentials = module.gitops_repo.git_credentials
  gitops_config = module.gitops_repo.gitops_config
  namespace = var.gitops-cp-apic-operator_namespace
  server_name = module.gitops_repo.server_name
}
module "gitops-cp-catalogs" {
  source = "github.com/cloud-native-toolkit/terraform-gitops-cp-catalogs?ref=v1.2.7"

  entitlement_key = var.entitlement_key
  git_credentials = module.gitops_repo.git_credentials
  gitops_config = module.gitops_repo.gitops_config
  kubeseal_cert = module.gitops_repo.sealed_secrets_cert
  server_name = module.gitops_repo.server_name
}
module "gitops-cp-platform-navigator" {
  source = "github.com/cloud-native-toolkit/terraform-gitops-cp-platform-navigator?ref=v2.0.2"

  catalog = module.gitops-cp-catalogs.catalog_ibmoperators
  catalog_namespace = var.gitops-cp-platform-navigator_catalog_namespace
  channel = module.cp4i-version-dependency.platform_navigator.channel
  entitlement_key = module.gitops-cp-catalogs.entitlement_key
  git_credentials = module.gitops_repo.git_credentials
  gitops_config = module.gitops_repo.gitops_config
  instance_version = module.cp4i-version-dependency.platform_navigator.version
  kubeseal_cert = module.gitops_repo.sealed_secrets_cert
  license = module.cp4i-version-dependency.platform_navigator.license
  namespace = module.cp4i-apic.name
  replica_count = var.gitops-cp-platform-navigator_replica_count
  server_name = module.gitops_repo.server_name
  storageclass = var.gitops-cp-platform-navigator_storageclass
  subscription_namespace = var.gitops-cp-platform-navigator_subscription_namespace
}
module "olm" {
  source = "github.com/cloud-native-toolkit/terraform-k8s-olm?ref=v1.3.5"

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
module "util-clis" {
  source = "cloud-native-toolkit/clis/util"
  version = "1.18.1"

  bin_dir = var.util-clis_bin_dir
  clis = var.util-clis_clis == null ? null : jsondecode(var.util-clis_clis)
}
