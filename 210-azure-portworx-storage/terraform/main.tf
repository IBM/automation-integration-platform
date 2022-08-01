module "azure-portworx" {
  source = "github.com/cloud-native-toolkit/terraform-azure-portworx?ref=v1.0.2"

  azure_client_id = var.azure_client_id
  azure_client_secret = var.azure_client_secret
  azure_subscription_id = var.azure_subscription_id
  azure_tenant_id = var.azure_tenant_id
  cluster_config_file = module.cluster.config_file_path
  cluster_type = var.azure-portworx_cluster_type
  disk_size = var.azure-portworx_disk_size
  enable_encryption = var.azure-portworx_enable_encryption
  kvdb_disk_size = var.azure-portworx_kvdb_disk_size
  portworx_spec = var.portworx_spec
  portworx_spec_file = var.portworx_spec_file
  provision = var.azure-portworx_provision
  px_enable_csi = var.azure-portworx_px_enable_csi
  px_enable_monitoring = var.azure-portworx_px_enable_monitoring
}
module "cluster" {
  source = "github.com/cloud-native-toolkit/terraform-ocp-login?ref=v1.5.1"

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
