
provider "gitops" {


  bin_dir = module.util-clis.bin_dir
}
provider "ibm" {


  ibmcloud_api_key = var.ibmcloud_api_key
  region = var.region
}