# IBM-ODF

This module will install OpenShift Data Foundation for OpenShift/ROKS clusters on IBM Cloud.
Installation happens inside of a script, within a `Job` that is executed on the cluster and configured using the GitOps approach.   

The job runs within the `"quay.io/ibmgaragecloud/cli-tools"` container, uses the IBM Cloud CLI to install the OpenShift Data Foundation add-on, because OCS cannot be installed on ROKS clusters using the helm chart.

The Job will: 
1. Log into the IBM Cloud CLI
2. Update the kubernetes-service plugin so that it always uses the latest version
3. Install ODF using `ibmcloud oc cluster addon enable openshift-data-foundation`

**Note:** Since this module uses the `openshift-data-foundation` addon, the module supports all OpenShift versions supported by the addon. See the [addon changelog](https://cloud.ibm.com/docs/openshift?topic=openshift-odf_addon_changelog) for more details.


### Command-line tools

- terraform - v12
- kubectl

### Terraform providers

- IBM Cloud provider >= 1.5.3
- Helm provider >= 1.1.1 (provided by Terraform)

## Module dependencies

This module makes use of the output from other modules:

- GitOps - https://github.com/cloud-native-toolkit/terraform-tools-gitops.git
- Namespace - https://github.com/cloud-native-toolkit/terraform-gitops-namespace.git


## Example usage

```hcl-terraform
module "gitops_module" {
  source = "github.com/cloud-native-toolkit/terraform-gitops-ibm-odf"

  gitops_config = module.gitops.gitops_config
  git_credentials = module.gitops.git_credentials
  server_name = module.gitops.server_name
  namespace = module.gitops_namespace.name
  kubeseal_cert = module.gitops.sealed_secrets_cert
  cluster_name = var.cluster_name
  region = var.region
  ibmcloud_api_key = var.ibmcloud_api_key
}
```

