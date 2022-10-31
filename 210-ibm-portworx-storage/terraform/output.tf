output "gitops-ibm-portworx_name" {
  description = "The name of the module"
  value = module.gitops-ibm-portworx.name
}
output "gitops-ibm-portworx_branch" {
  description = "The branch where the module config has been placed"
  value = module.gitops-ibm-portworx.branch
}
output "gitops-ibm-portworx_namespace" {
  description = "The namespace where the module will be deployed"
  value = module.gitops-ibm-portworx.namespace
}
output "gitops-ibm-portworx_server_name" {
  description = "The server where the module will be deployed"
  value = module.gitops-ibm-portworx.server_name
}
output "gitops-ibm-portworx_layer" {
  description = "The layer where the module is deployed"
  value = module.gitops-ibm-portworx.layer
}
output "gitops-ibm-portworx_type" {
  description = "The type of module where the module is deployed"
  value = module.gitops-ibm-portworx.type
}
output "gitops-ibm-portworx_region" {
  description = "The region where the portworx resource has been delivered"
  value = module.gitops-ibm-portworx.region
}
output "gitops-ibm-portworx_resource_group_id" {
  description = "The id of the resource group where the portworx resource has been delivered"
  value = module.gitops-ibm-portworx.resource_group_id
}
output "portworx_namespace_name" {
  description = "Namespace name"
  value = module.portworx_namespace.name
}
output "gitops_repo_config_host" {
  description = "The host name of the bootstrap git repo"
  value = module.gitops_repo.config_host
}
output "gitops_repo_config_org" {
  description = "The org name of the bootstrap git repo"
  value = module.gitops_repo.config_org
}
output "gitops_repo_config_name" {
  description = "The repo name of the bootstrap git repo"
  value = module.gitops_repo.config_name
}
output "gitops_repo_config_project" {
  description = "The project name of the bootstrap git repo (for Azure DevOps)"
  value = module.gitops_repo.config_project
}
output "gitops_repo_config_repo" {
  description = "The repo that contains the argocd configuration"
  value = module.gitops_repo.config_repo
}
output "gitops_repo_config_repo_url" {
  description = "The repo that contains the argocd configuration"
  value = module.gitops_repo.config_repo_url
}
output "gitops_repo_config_username" {
  description = "The username for the config repo"
  value = module.gitops_repo.config_username
}
output "gitops_repo_config_token" {
  description = "The token for the config repo"
  value = module.gitops_repo.config_token
  sensitive = true
}
output "gitops_repo_config_paths" {
  description = "The paths in the config repo"
  value = module.gitops_repo.config_paths
}
output "gitops_repo_config_projects" {
  description = "The ArgoCD projects for the different layers of the repo"
  value = module.gitops_repo.config_projects
}
output "gitops_repo_bootstrap_path" {
  description = "The path to the bootstrap configuration"
  value = module.gitops_repo.bootstrap_path
}
output "gitops_repo_bootstrap_branch" {
  description = "The branch in the gitrepo containing the bootstrap configuration"
  value = module.gitops_repo.bootstrap_branch
}
output "gitops_repo_application_repo" {
  description = "The repo that contains the application configuration"
  value = module.gitops_repo.application_repo
}
output "gitops_repo_application_repo_url" {
  description = "The repo that contains the application configuration"
  value = module.gitops_repo.application_repo_url
}
output "gitops_repo_application_username" {
  description = "The username for the application repo"
  value = module.gitops_repo.application_username
}
output "gitops_repo_application_token" {
  description = "The token for the application repo"
  value = module.gitops_repo.application_token
  sensitive = true
}
output "gitops_repo_application_paths" {
  description = "The paths in the application repo"
  value = module.gitops_repo.application_paths
}
output "gitops_repo_gitops_config" {
  description = "Config information regarding the gitops repo structure"
  value = module.gitops_repo.gitops_config
}
output "gitops_repo_git_credentials" {
  description = "The credentials for the gitops repo(s)"
  value = module.gitops_repo.git_credentials
  sensitive = true
}
output "gitops_repo_server_name" {
  description = "The name of the cluster that will be configured for gitops"
  value = module.gitops_repo.server_name
}
output "gitops_repo_sealed_secrets_cert" {
  description = "The certificate used to encrypt sealed secrets"
  value = module.gitops_repo.sealed_secrets_cert
}
output "resource_group_name" {
  description = "The name of the resource group"
  value = module.resource_group.name
}
output "resource_group_id" {
  description = "The id of the resource group"
  value = module.resource_group.id
}
output "resource_group_group" {
  description = "The resource group object"
  value = module.resource_group.group
}
output "resource_group_sync" {
  description = "Value used to order the provisioning of the resource group"
  value = module.resource_group.sync
}
output "resource_group_provision" {
  description = "Flag indicating that the resource group was provisioned by this module"
  value = module.resource_group.provision
}
output "resource_group_tags" {
  description = "Flag indicating that the resource group was provisioned by this module"
  value = module.resource_group.tags
}
output "gitops-ibmcloud-operator_name" {
  description = "The name of the module"
  value = module.gitops-ibmcloud-operator.name
}
output "gitops-ibmcloud-operator_branch" {
  description = "The branch where the module config has been placed"
  value = module.gitops-ibmcloud-operator.branch
}
output "gitops-ibmcloud-operator_namespace" {
  description = "The namespace where the module will be deployed"
  value = module.gitops-ibmcloud-operator.namespace
}
output "gitops-ibmcloud-operator_server_name" {
  description = "The server where the module will be deployed"
  value = module.gitops-ibmcloud-operator.server_name
}
output "gitops-ibmcloud-operator_layer" {
  description = "The layer where the module is deployed"
  value = module.gitops-ibmcloud-operator.layer
}
output "gitops-ibmcloud-operator_type" {
  description = "The type of module where the module is deployed"
  value = module.gitops-ibmcloud-operator.type
}
output "util-clis_bin_dir" {
  description = "Directory where the clis were downloaded"
  value = module.util-clis.bin_dir
}
