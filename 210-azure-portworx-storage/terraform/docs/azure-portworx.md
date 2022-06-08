# azure-portworx


### Description

Terraform module to install Portworx into an OCP/ARO/IPI cluster on Azure, compatible with modules from https://modules.cloudnativetoolkit.dev

### Prerequisites

This module has 2 manual steps that must be completed before successful deployment:

1. Azure service principal/credentials
2. Portworx configuration

#### Azure service principal/credentials

The provided `scripts/portworx-prereq.sh` script will collect/create the necessary service principle. The script required the resource group name, cluster name, and cluster type as input. Optionally the subscription id can be provided. If not provided, the subscription id will be looked up.

1. Log into your Azure account using the `az` cli.
2. Run the `scripts/portworx-prereq.sh` script.

    ```shell
    ./scripts/portworx-prereq.sh -t aro -r rg-name -c cluster-name
    ```

3. If successful, the output of the script will look like the following. The output values can be provided as input to the automation.

    ```json
    {
      "azure_client_id": "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX",
      "azure_client_secret": "XXXXXXX",
      "azure_tenant_id": "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX",
      "azure_subscription_id": "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX"
    }
    ```

Alternatively, you can use known credentials for an existing service principal to allow Portworx to provision volumes for the cluster.

##### Service principle details

A service principal (service account) is used by the Portworx deployment to provision storage volumes that will be leveraged by Portworx once deployed into the OpenShift cluster.   There are some specifics for service principals when deploying portworx, as detailed below:

- **ARO Clusters:** - For ARO clusters, you must use the service principal that was created in the background when the ARO cluster was created.  
- **IPI Clusters:** - For IPI clusters, you must create a service principal that has the following permissions:

  - `Microsoft.ContainerService/managedClusters/agentPools/read`
  - `Microsoft.Compute/disks/delete`
  - `Microsoft.Compute/disks/write`
  - `Microsoft.Compute/disks/read`
  - `Microsoft.Compute/virtualMachines/write`
  - `Microsoft.Compute/virtualMachines/read`
  - `Microsoft.Compute/virtualMachineScaleSets/virtualMachines/write`
  - `Microsoft.Compute/virtualMachineScaleSets/virtualMachines/read`

Before attempting to deploy this module, you can log into the `az` cli, and manually run the `scripts/portworx-prereq.sh` script, which will handle both of these cases.  This script will output the credentials that are required to successfully deploy Portworx into the cluster. The output will be a JSON structure like: 


#### Portworx configuration

This module requires a Portworx configuration.   Portworx is available in 2 flavors: `Enterprise` and `Essentials`.   

*Portworx Essentials* is free forever, but only supports a maximum of 5 nodes on a cluster, 200 volumes, and 5TB of storage.   
*Portworx Enterprise* requires a subscription (has 30 day free trial), supports over 1000 nodes per cluster, and has unlimited storage.

More detailed comparisons are available at: https://portworx.com/products/features/

Instructions for obtaining your portworx configuration are available at [portworx config](./PORTWORX_CONFIG.md)

You can see an example in the [Example usage](#example-usage) section below.

### Software dependencies

The module depends on the following software components:

#### Command-line tools

- terraform >= v0.15

#### Terraform providers

- IBM Cloud provider >= 1.5.3

### Module dependencies

This module makes use of the output from other modules:

- Cluster - github.com/cloud-native-toolkit/terraform-ocp-login.git

### Example usage

Note: `osb_endpoint` and `user_id` are only required in `portworx_config` if `type` is `essentials`.  These values are not required for type `enterprise`. 

```hcl-terraform
locals {
  portworx_config = {
    cluster_id = var.px_cluster_id
    user_id = var.px_user_id
    osb_endpoint = var.px_osb_endpoint
    type = "essentials"
    enable_encryption = false
  }
}

module "portworx" {
  source = "./module"

  region                = var.region
  azure_client_id       = var.azure_client_id
  azure_client_secret   = var.azure_client_secret
  azure_subscription_id = var.azure_subscription_id
  azure_tenant_id       = var.azure_tenant_id
  cluster_name          = var.cluster_name
  cluster_config_file   = module.dev_cluster.platform.kubeconfig
  portworx_config       = local.portworx_config
  resource_group_name   = var.resource_group_name
}
```

## Acknowledgements
This module is derivative from https://github.com/ibm-hcbt/terraform-ibm-cloud-pak/tree/main/modules/portworx_aws

