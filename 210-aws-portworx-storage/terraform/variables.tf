variable "aws-portworx_provision" {
  type = string
  description = "If set to true installs Portworx on the given cluster"
  default = "true"
}
variable "access_key" {
  type = string
  description = "the value of access_key"
  default = ""
}
variable "secret_key" {
  type = string
  description = "the value of secret_key"
  default = ""
}
variable "region" {
  type = string
  description = "AWS Region the cluster is deployed in"
}
variable "aws-portworx_portworx_config" {
  type = string
  description = "Portworx configuration"
}
variable "aws-portworx_disk_size" {
  type = string
  description = "Disk size for each Portworx volume"
  default = "1000"
}
variable "aws-portworx_kvdb_disk_size" {
  type = string
  description = "the value of aws-portworx_kvdb_disk_size"
  default = "450"
}
variable "aws-portworx_px_enable_monitoring" {
  type = bool
  description = "Enable monitoring on PX"
  default = true
}
variable "aws-portworx_px_enable_csi" {
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
