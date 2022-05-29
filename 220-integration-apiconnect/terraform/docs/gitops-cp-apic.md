# IBM Cloud Pak API Connect Instance Module

Module to populate a gitops repository with the API Connect instance from IBM Cloud Pak for Integration.

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
- CP4I Dependency Management - github.com/cloud-native-toolkit/terraform-cp4i-dependency-management
- CP APIC Operator - github.com/cloud-native-toolkit/terraform-gitops-cp-apic-operator.git

## Example usage

```hcl-terraform
module "apic_instance" {
  source = "github.com/cloud-native-toolkit/terraform-gitops-cp-apic"

  gitops_config = module.gitops.gitops_config
  git_credentials = module.gitops.git_credentials
  server_name = module.gitops.server_name
  namespace = module.gitops_namespace.name
  kubeseal_cert = module.gitops.sealed_secrets_cert
  entitlement_key = var.cp_entitlement_key
  apic_version = module.cp4i-dependencies.apic.version
  license_id = module.cp4i-dependencies.apic.license
  usage = module.cp4i-dependencies.apic.license_use
}
```
