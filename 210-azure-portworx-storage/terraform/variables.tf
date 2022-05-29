variable "azure-portworx_provision" {
  type = string
  description = "If set to true installs Portworx on the given cluster"
  default = "true"
}
variable "azure_subscription_id" {
  type = string
  description = "the value of azure_subscription_id"
  default = ""
}
variable "azure_client_id" {
  type = string
  description = "the value of azure_client_id"
  default = ""
}
variable "azure_client_secret" {
  type = string
  description = "the value of azure_client_secret"
  default = ""
}
variable "azure_tenant_id" {
  type = string
  description = "the value of azure_tenant_id"
  default = ""
}
variable "azure-portworx_variable cluster_name {" {
  type = string
  description = "The name of the ARO cluster"
}
variable "region" {
  type = string
  description = "Azure Region the cluster is deployed in"
}
variable "azure-portworx_resource_group_name" {
  type = string
  description = "Resource group where cluster is deployed"
}
variable "azure-portworx_portworx_config" {
  type = string
  description = "Portworx configuration"
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
  description = "The version of the cluster (passed through to the output)"
  default = ""
}
variable "cluster_ingress_subdomain" {
  type = string
  description = "The ingress subdomain of the cluster (passed through to the output)"
  default = ""
}
variable "cluster_tls_secret_name" {
  type = string
  description = "The name of the secret containing the tls certificates for the ingress subdomain (passed through to the output)"
  default = ""
}
