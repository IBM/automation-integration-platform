output "cp4i-version-dependency_platform_navigator" {
  description = "Platform navigator operator configuration"
  value = module.cp4i-version-dependency.platform_navigator
}
output "cp4i-version-dependency_mq" {
  description = "MQ operator configuration"
  value = module.cp4i-version-dependency.mq
}
output "cp4i-version-dependency_ace" {
  description = "ACE operator configuration"
  value = module.cp4i-version-dependency.ace
}
output "cp4i-version-dependency_apic" {
  description = "API Connect operator configuration"
  value = module.cp4i-version-dependency.apic
}
output "cp4i-version-dependency_eventstreams" {
  description = "IBM Eventstreams operator configuration"
  value = module.cp4i-version-dependency.eventstreams
}
output "cp4i-version-dependency_asset_repository" {
  description = "IBM Eventstreams operator configuration"
  value = module.cp4i-version-dependency.asset_repository
}
output "cp4i-version-dependency_operations_dashboard" {
  description = "IBM Eventstreams operator configuration"
  value = module.cp4i-version-dependency.operations_dashboard
}
output "cp4i-version-dependency_aspera" {
  description = "IBM Aspera HSTS operator configuration"
  value = module.cp4i-version-dependency.aspera
}
output "cp4i-version-dependency_datapower" {
  description = "IBM DataPower operator configuration"
  value = module.cp4i-version-dependency.datapower
}
output "gitops-cp-ace_name" {
  description = "The name of the module"
  value = module.gitops-cp-ace.name
}
output "gitops-cp-ace_branch" {
  description = "The branch where the module config has been placed"
  value = module.gitops-cp-ace.branch
}
output "gitops-cp-ace_namespace" {
  description = "The namespace where the module will be deployed"
  value = module.gitops-cp-ace.namespace
}
output "gitops-cp-ace_server_name" {
  description = "The server where the module will be deployed"
  value = module.gitops-cp-ace.server_name
}
output "gitops-cp-ace_layer" {
  description = "The layer where the module is deployed"
  value = module.gitops-cp-ace.layer
}
output "gitops-cp-ace_type" {
  description = "The type of module where the module is deployed"
  value = module.gitops-cp-ace.type
}
output "gitops-cp-ace-designer_name" {
  description = "The name of the module"
  value = module.gitops-cp-ace-designer.name
}
output "gitops-cp-ace-designer_branch" {
  description = "The branch where the module config has been placed"
  value = module.gitops-cp-ace-designer.branch
}
output "gitops-cp-ace-designer_namespace" {
  description = "The namespace where the module will be deployed"
  value = module.gitops-cp-ace-designer.namespace
}
output "gitops-cp-ace-designer_server_name" {
  description = "The server where the module will be deployed"
  value = module.gitops-cp-ace-designer.server_name
}
output "gitops-cp-ace-designer_layer" {
  description = "The layer where the module is deployed"
  value = module.gitops-cp-ace-designer.layer
}
output "gitops-cp-ace-designer_type" {
  description = "The type of module where the module is deployed"
  value = module.gitops-cp-ace-designer.type
}
output "gitops-cp-catalogs_name" {
  description = "The name of the module"
  value = module.gitops-cp-catalogs.name
}
output "gitops-cp-catalogs_branch" {
  description = "The branch where the module config has been placed"
  value = module.gitops-cp-catalogs.branch
}
output "gitops-cp-catalogs_namespace" {
  description = "The namespace where the module will be deployed"
  value = module.gitops-cp-catalogs.namespace
}
output "gitops-cp-catalogs_server_name" {
  description = "The server where the module will be deployed"
  value = module.gitops-cp-catalogs.server_name
}
output "gitops-cp-catalogs_layer" {
  description = "The layer where the module is deployed"
  value = module.gitops-cp-catalogs.layer
}
output "gitops-cp-catalogs_type" {
  description = "The type of module where the module is deployed"
  value = module.gitops-cp-catalogs.type
}
output "gitops-cp-catalogs_catalog_ibmoperators" {
  description = "IBM Operator Catalog name"
  value = module.gitops-cp-catalogs.catalog_ibmoperators
}
output "gitops-cp-catalogs_catalog_commonservices" {
  description = "IBMCS Operators catalog name"
  value = module.gitops-cp-catalogs.catalog_commonservices
}
output "gitops-cp-catalogs_catalog_automationfoundation" {
  description = "IAF Core Operators catalog name"
  value = module.gitops-cp-catalogs.catalog_automationfoundation
}
output "gitops-cp-catalogs_catalog_processmining" {
  description = "IBM ProcessMining Operators catalog name"
  value = module.gitops-cp-catalogs.catalog_processmining
}
output "gitops-cp-catalogs_entitlement_key" {
  description = "Entitlement key"
  value = module.gitops-cp-catalogs.entitlement_key
  sensitive = true
}
output "cp4i-ace_name" {
  description = "Namespace name"
  value = module.cp4i-ace.name
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
output "gitea_namespace_name" {
  description = "Namespace name"
  value = module.gitea_namespace.name
}
output "cluster_id" {
  description = "ID of the cluster."
  value = module.cluster.id
}
output "cluster_ocp_id" {
  description = "OpenShift ID of the cluster."
  value = module.cluster.ocp_id
}
output "cluster_name" {
  description = "Name of the cluster"
  value = module.cluster.name
}
output "cluster_region" {
  description = "Region of the cluster"
  value = module.cluster.region
}
output "cluster_resource_group_name" {
  description = "Resource group of the cluster"
  value = module.cluster.resource_group_name
}
output "cluster_server_url" {
  description = "The url of the control server."
  value = module.cluster.server_url
}
output "cluster_username" {
  description = "The username of the control server."
  value = module.cluster.username
}
output "cluster_password" {
  description = "The password of the control server."
  value = module.cluster.password
  sensitive = true
}
output "cluster_token" {
  description = "The token of the control server."
  value = module.cluster.token
  sensitive = true
}
output "cluster_config_file_path" {
  description = "Path to the config file for the cluster."
  value = module.cluster.config_file_path
}
output "cluster_platform" {
  description = "Configuration values for the cluster platform"
  value = module.cluster.platform
}
output "cluster_ca_cert" {
  description = "Base64 encoded CA certificate for cluster endpoints"
  value = module.cluster.ca_cert
}
output "olm_olm_namespace" {
  description = "Namespace where OLM is running. The value will be different between OCP 4.3 and IKS/OCP 3.11"
  value = module.olm.olm_namespace
}
output "olm_target_namespace" {
  description = "Namespace where operatoes will be installed"
  value = module.olm.target_namespace
}
output "olm_operator_namespace" {
  description = "Name space where catalog is running - and subscriptions need to be made"
  value = module.olm.operator_namespace
}
output "gitea_namespace" {
  description = "The namespace where the Gitea instance has been provisioned"
  value = module.gitea.namespace
}
output "gitea_username" {
  description = "The username of the Gitea admin user"
  value = module.gitea.username
}
output "gitea_password" {
  description = "The password of the Gitea admin user"
  value = module.gitea.password
  sensitive = true
}
output "gitea_token" {
  description = "The api token of the Gitea admin user"
  value = module.gitea.token
  sensitive = true
}
output "gitea_host" {
  description = "The host name of the gitea server"
  value = module.gitea.host
}
output "gitea_org" {
  description = "The host name of the gitea server"
  value = module.gitea.org
}
output "gitea_ingress_host" {
  description = "The host name of the gitea server"
  value = module.gitea.ingress_host
}
output "gitea_ingress_url" {
  description = "The url of the gitea server"
  value = module.gitea.ingress_url
}
output "gitea_ca_cert" {
  description = "Base64 encoded CA certificate for cluster endpoints"
  value = module.gitea.ca_cert
}
output "sealed-secret-cert_private_key" {
  description = "the value of sealed-secret-cert_private_key"
  value = module.sealed-secret-cert.private_key
  sensitive = true
}
output "sealed-secret-cert_cert" {
  description = "the value of sealed-secret-cert_cert"
  value = module.sealed-secret-cert.cert
}
output "util-clis_bin_dir" {
  description = "Directory where the clis were downloaded"
  value = module.util-clis.bin_dir
}
