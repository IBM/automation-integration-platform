# IBM Cloud Operator module

Module to populate a gitops repository with the resources required to provision the IBM Cloud operator in a cluster.

## Software dependencies

The module depends on the following software components:

### Command-line tools

- terraform - v0.15

### Terraform providers

- None

## Module dependencies

This module makes use of the output from other modules:

- GitOps - github.com/cloud-native-toolkit/terraform-tools-gitops.git
- Namespace - github.com/cloud-native-toolkit/terraform-gitops-namespace.git

## Example usage

[Refer the test cases for this module](test/stages/stage2-mymodule.tf)

```hcl-terraform
module "ibmcloud_operators" {
  source = "github.com/cloud-native-toolkit/terraform-gitops-ibmcloud-operator.git"

  cluster_config_file = module.dev_cluster.config_file_path
  cluster_type        = module.dev_cluster.type
  app_namespace       = module.dev_cluster_namespaces.tools_namespace_name
  ingress_subdomain   = module.dev_cluster.ingress_hostname
  olm_namespace       = module.dev_software_olm.olm_namespace
  operator_namespace  = module.dev_software_olm.target_namespace
  name                = "argocd"
}
```

### Module test logic

The `test/stages` folder contains the terraform template needed to execute the module. By convention, each module is defined in its own file. Also by convention, all prereqs or dependencies for the module are named `stage1-xxx` and the module to be tested is named `stage2-xxx`. The default test templates in the GitOps repo are set up to provision a GitOps repository, log into a cluster, provision ArgoCD in the cluster and bootstrap it with the GitOps repository, provision a namespace via GitOps where the module will be deployed then apply the module logic. The end result of this test terraform template should be a cluster that has been provisioned with the components of the module via the GitOps repository.

This test logic will run every time a change is made to the repository to ensure there are no regressions to the module.





