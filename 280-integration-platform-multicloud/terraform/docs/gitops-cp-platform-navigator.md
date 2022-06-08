# Platform Navigator gitops module

Module to populate a gitops repository with the resources to deploy Platorm Navigator from IBM Cloud Pak for Integration. This is the special type of module
which creates the following
  1. PlatformNavigator Operator
  2. Instance of PlatformNavigator

## Software dependencies

The module depends on the following software components:

### Command-line tools

- terraform >= v0.15

### Terraform providers

None

## Module dependencies

This module makes use of the output from other modules:

- GitOps - github.com/cloud-native-toolkit/terraform-tools-gitops.git
- Namespace - github.com/cloud-native-toolkit/terraform-gitops-namespace.git
- Catalogs - github.com/cloud-native-toolkit/terraform-gitops-cp-catalogs.git
- Cp4i-Dependency - github.com/cloud-native-toolkit/terraform-cp4i-dependency-management.git

Please note, This specific module has a dependency on RWX AccessMode StorageClass. Normally If we do not specify 'StorageClass' while deploying workload, the storageclass patchced with 'default' will be assigned. Hence please double check the RWX supported storage class is available before proceed.

## Example usage

```hcl-terraform
module "dev_tools_argocd" {
  source = "github.com/cloud-native-toolkit/terraform-tools-argocd.git"

  cluster_config_file = module.dev_cluster.config_file_path
  cluster_type        = module.dev_cluster.type
  app_namespace       = module.dev_cluster_namespaces.tools_namespace_name
  ingress_subdomain   = module.dev_cluster.ingress_hostname
  olm_namespace       = module.dev_software_olm.olm_namespace
  operator_namespace  = module.dev_software_olm.target_namespace
  name                = "argocd"
}
```

