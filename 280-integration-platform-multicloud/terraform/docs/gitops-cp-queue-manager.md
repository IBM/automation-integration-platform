# CP4I - MQ instance module

Module to create a single MQ instance with persistence. Module also creates a config map to define all the MQ objects to integrate with Sterling OMS for telco cloud solution.

## Software dependencies

The module depends on the following software components:

### Command-line tools

- terraform - v15
- kubectl

### Terraform providers

- IBM Cloud provider >= 1.5.3
- Helm provider >= 1.1.1 (provided by Terraform)

## Module dependencies

This module makes use of the output from other modules:

- GitOps - github.com/cloud-native-toolkit/terraform-tools-gitops.git
- Namespace - github.com/cloud-native-toolkit/terraform-gitops-namespace.git
- Catalogs - github.com/cloud-native-toolkit/terraform-gitops-cp-catalogs.git
- MQ Operator - github.com/cloud-native-toolkit/terraform-gitops-cp-mq.git
- CP4I-Dependency - github.com/cloud-native-toolkit/terraform-cp4i-dependency-management.git

## Example usage

```hcl-terraform
module "mq_instance" {
   source = "github.com/cloud-native-toolkit/terraform-gitops-cp-queue-manager.git"

   depends_on = [
      module.gitops-cp-mq
   ]

   gitops_config = module.gitops.gitops_config
   git_credentials = module.gitops.git_credentials
   server_name = module.gitops.server_name
   namespace = module.gitops_namespace.name
   kubeseal_cert = module.gitops.sealed_secrets_cert
   entitlement_key = module.cp_catalogs.entitlement_key
   license = module.cp4i-dependencies.mq.license
   qmgr_instance_name = var.qmgr_instance_name
   qmgr_name = var.qmgr_name
   config_map = var.config_map
   storageClass = var.storageClass
}

```
