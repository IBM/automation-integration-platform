variable "azure-portworx_provision" {
  type = string
  description = "If set to true installs Portworx on the given cluster"
  default = "true"
}
variable "azure_subscription_id" {
  type = string
  description = "The subscription id of the Azure account where the OpenShift cluster has been provisioned"
}
variable "azure_tenant_id" {
  type = string
  description = "The tenant id of the Azure account where the OpenShift cluster has been provisioned"
}
variable "azure_client_id" {
  type = string
  description = "The client id used to access the Azure account"
}
variable "azure_client_secret" {
  type = string
  description = "The client secret used to access the Azure account"
}
variable "azure-portworx_cluster_type" {
  type = string
  description = "Type of OCP cluster on Azure (ARO | IPI)"
  default = "ARO"
}
variable "azure-portworx_disk_size" {
  type = string
  description = "Disk size for each Portworx volume"
  default = "1000"
}
variable "azure-portworx_kvdb_disk_size" {
  type = string
  description = "the value of azure-portworx_kvdb_disk_size"
  default = "150"
}
variable "azure-portworx_px_enable_monitoring" {
  type = bool
  description = "Enable monitoring on PX"
  default = true
}
variable "azure-portworx_px_enable_csi" {
  type = bool
  description = "Enable CSI on PX"
  default = true
}
variable "portworx_spec_file" {
  type = string
  description = "The path to the file that contains the yaml spec for the Portworx config. Either the `portworx_spec_file` or `portworx_spec` must be provided. The instructions for creating this configuration can be found at https://github.com/cloud-native-toolkit/terraform-azure-portworx/blob/main/PORTWORX_CONFIG.md"
  default = ""
}
variable "portworx_spec" {
  type = string
  description = "The yaml spec for the Portworx config. Either the `portworx_spec_file` or `portworx_spec` must be provided. The instructions for creating this configuration can be found at https://github.com/cloud-native-toolkit/terraform-azure-portworx/blob/main/PORTWORX_CONFIG.md"
  default = ""
}
variable "azure-portworx_enable_encryption" {
  type = bool
  description = "Flag indicating portworx volumes should be encrypted"
  default = false
}
variable "server_url" {
  type = string
  description = "The url for the OpenShift api"
}
variable "cluster_login_user" {
  type = string
  description = "Username for login"
  default = ""
}
variable "cluster_login_password" {
  type = string
  description = "Password for login"
  default = ""
}
variable "cluster_login_token" {
  type = string
  description = "Token used for authentication"
}
variable "cluster_skip" {
  type = bool
  description = "Flag indicating that the cluster login has already been performed"
  default = false
}
variable "cluster_cluster_version" {
  type = string
  description = "[Deprecated] The version of the cluster (passed through to the output)"
  default = ""
}
variable "cluster_ingress_subdomain" {
  type = string
  description = "[Deprecated] The ingress subdomain of the cluster (passed through to the output)"
  default = ""
}
variable "cluster_tls_secret_name" {
  type = string
  description = "[Deprecated] The name of the secret containing the tls certificates for the ingress subdomain (passed through to the output)"
  default = ""
}
variable "cluster_ca_cert" {
  type = string
  description = "The base64 encoded ca certificate"
  default = ""
}
variable "cluster_ca_cert_file" {
  type = string
  description = "The path to the file that contains the ca certificate"
  default = ""
}
