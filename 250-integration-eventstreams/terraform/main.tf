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
module "cp4i-es" {
  source = "github.com/cloud-native-toolkit/terraform-gitops-namespace?ref=v1.15.0"

  argocd_namespace = var.cp4i-es_argocd_namespace
  ci = var.cp4i-es_ci
  create_operator_group = var.cp4i-es_create_operator_group
  git_credentials = module.gitops_repo.git_credentials
  gitops_config = module.gitops_repo.gitops_config
  name = var.cp4i-es_name
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
module "gitops-cp-catalogs" {
  source = "github.com/cloud-native-toolkit/terraform-gitops-cp-catalogs?ref=v1.2.7"

  entitlement_key = var.entitlement_key
  git_credentials = module.gitops_repo.git_credentials
  gitops_config = module.gitops_repo.gitops_config
  kubeseal_cert = module.gitops_repo.sealed_secrets_cert
  server_name = module.gitops_repo.server_name
}
module "gitops-cp-es-operator" {
  source = "github.com/cloud-native-toolkit/terraform-gitops-cp-es-operator?ref=v1.1.1"

  catalog = module.gitops-cp-catalogs.catalog_ibmoperators
  catalog_namespace = var.gitops-cp-es-operator_catalog_namespace
  channel = module.cp4i-version-dependency.eventstreams.channel
  git_credentials = module.gitops_repo.git_credentials
  gitops_config = module.gitops_repo.gitops_config
  namespace = var.gitops-cp-es-operator_namespace
  server_name = module.gitops_repo.server_name
}
module "gitops-cp-event-streams" {
  source = "github.com/cloud-native-toolkit/terraform-gitops-cp-event-streams?ref=v2.1.1"

  cpulimits = var.gitops-cp-event-streams_cpulimits
  cpurequests = var.gitops-cp-event-streams_cpurequests
  entitlement_key = module.gitops-cp-catalogs.entitlement_key
  es_apiVersion = var.gitops-cp-event-streams_es_apiVersion
  es_version = var.gitops-cp-event-streams_es_version
  git_credentials = module.gitops_repo.git_credentials
  gitops_config = module.gitops_repo.gitops_config
  kafka_inter_broker_protocol_version = var.gitops-cp-event-streams_kafka_inter_broker_protocol_version
  kafka_listeners = var.gitops-cp-event-streams_kafka_listeners
  kafka_log_message_format_version = var.gitops-cp-event-streams_kafka_log_message_format_version
  kafka_replicas = var.gitops-cp-event-streams_kafka_replicas
  kafka_storageclass = var.rwo_storage_class
  kafka_storagesize = var.gitops-cp-event-streams_kafka_storagesize
  kafka_storagetype = var.gitops-cp-event-streams_kafka_storagetype
  kubeseal_cert = module.gitops_repo.sealed_secrets_cert
  license_use = module.cp4i-version-dependency.eventstreams.license_use
  memorylimits = var.gitops-cp-event-streams_memorylimits
  memoryrequests = var.gitops-cp-event-streams_memoryrequests
  namespace = module.cp4i-es.name
  requestIbmServices_iam = var.gitops-cp-event-streams_requestIbmServices_iam
  requestIbmServices_monitoring = var.gitops-cp-event-streams_requestIbmServices_monitoring
  server_name = module.gitops_repo.server_name
  service_name = var.gitops-cp-event-streams_service_name
  zookeeper_replicas = var.gitops-cp-event-streams_zookeeper_replicas
  zookeeper_storageclass = var.rwo_storage_class
  zookeeper_storagesize = var.gitops-cp-event-streams_zookeeper_storagesize
  zookeeper_storagetype = var.gitops-cp-event-streams_zookeeper_storagetype
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
