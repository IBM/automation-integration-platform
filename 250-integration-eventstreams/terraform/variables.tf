variable "gitops-cp-catalogs_namespace" {
  type = string
  description = "The namespace where the application should be deployed"
  default = "openshift-marketplace"
}
variable "entitlement_key" {
  type = string
  description = "The entitlement key used to access the CP4I images in the container registry. Visit https://myibm.ibm.com/products-services/containerlibrary to get the key"
}
variable "gitops-cp-event-streams_requestIbmServices_iam" {
  type = bool
  description = "IAM services"
  default = true
}
variable "gitops-cp-event-streams_requestIbmServices_monitoring" {
  type = bool
  description = "Monitoring services"
  default = true
}
variable "gitops-cp-event-streams_kafka_replicas" {
  type = number
  description = "Number of kafka replicas"
  default = 3
}
variable "gitops-cp-event-streams_zookeeper_replicas" {
  type = number
  description = "Number of zookeeper replicas"
  default = 3
}
variable "gitops-cp-event-streams_es_version" {
  type = string
  description = "Version of Event streams to be installed"
  default = "10.5.0"
}
variable "gitops-cp-event-streams_cpulimits" {
  type = string
  description = "CPU limits for the kafka instance"
  default = "1"
}
variable "gitops-cp-event-streams_cpurequests" {
  type = string
  description = "CPU requests for the kafka instance"
  default = "100m"
}
variable "gitops-cp-event-streams_memorylimits" {
  type = string
  description = "Memory limits for the kafka instance"
  default = "2Gi"
}
variable "gitops-cp-event-streams_memoryrequests" {
  type = string
  description = "Memory requests for the kafka instance"
  default = "128Mi"
}
variable "rwo_storage_class" {
  type = string
  description = "ReadWriteOnce access type Storage Class"
  default = "ibmc-vpc-block-10iops-tier"
}
variable "gitops-cp-event-streams_kafka_storagetype" {
  type = string
  description = "Storage type for kafka"
  default = "persistent-claim"
}
variable "gitops-cp-event-streams_zookeeper_storagetype" {
  type = string
  description = "Storage type for zookeeper"
  default = "persistent-claim"
}
variable "gitops-cp-event-streams_kafka_storagesize" {
  type = string
  description = "Storage size - applicable only for persistent storage type"
  default = "10Gi"
}
variable "gitops-cp-event-streams_zookeeper_storagesize" {
  type = string
  description = "Storage size - applicable only for persistent storage type"
  default = "4Gi"
}
variable "gitops-cp-event-streams_service_name" {
  type = string
  description = "Event stream instance name"
  default = "es-instance"
}
variable "gitops-cp-eventstreams-operator_namespace" {
  type = string
  description = "The namespace where the application should be deployed"
  default = "openshift-operators"
}
variable "gitops-cp-eventstreams-operator_catalog_namespace" {
  type = string
  description = "The namespace where the catalog has been deployed"
  default = "openshift-marketplace"
}
variable "cp4i-es_name" {
  type = string
  description = "The value that should be used for the namespace"
  default = "cp4i-es"
}
variable "cp4i-es_ci" {
  type = bool
  description = "Flag indicating that this namespace will be used for development (e.g. configmaps and secrets)"
  default = false
}
variable "cp4i-es_create_operator_group" {
  type = bool
  description = "Flag indicating that an operator group should be created in the namespace"
  default = true
}
variable "cp4i-es_argocd_namespace" {
  type = string
  description = "The namespace where argocd has been deployed"
  default = "openshift-gitops"
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
variable "sealed-secret-cert_cert" {
  type = string
  description = "The public key that will be used to encrypt sealed secrets. If not provided, a new one will be generated"
  default = ""
}
variable "sealed-secret-cert_private_key" {
  type = string
  description = "The private key that will be used to decrypt sealed secrets. If not provided, a new one will be generated"
  default = ""
}
variable "sealed-secret-cert_cert_file" {
  type = string
  description = "The file containing the public key that will be used to encrypt the sealed secrets. If not provided a new public key will be generated"
  default = ""
}
variable "sealed-secret-cert_private_key_file" {
  type = string
  description = "The file containin the private key that will be used to encrypt the sealed secrets. If not provided a new private key will be generated"
  default = ""
}
variable "gitops_repo_host" {
  type = string
  description = "The host for the git repository."
}
variable "gitops_repo_type" {
  type = string
  description = "The type of the hosted git repository (github or gitlab)."
}
variable "gitops_repo_org" {
  type = string
  description = "The org/group where the git repository exists/will be provisioned."
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
variable "gitops_repo_username" {
  type = string
  description = "The username of the user with access to the repository"
}
variable "gitops_repo_token" {
  type = string
  description = "The personal access token used to access the repository"
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
variable "gitops_repo_strict" {
  type = bool
  description = "Flag indicating that an error should be thrown if the repo already exists"
  default = false
}
variable "cp4i-dependency-management_cp4i_version" {
  type = string
  description = "The CP4i Version. Possible values are (2021_4_1 , 2022_1_1). If no values is set by default this will refer to Latest available CP4i version"
  default = ""
}
