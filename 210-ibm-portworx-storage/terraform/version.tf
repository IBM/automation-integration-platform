terraform {
  required_providers {
    gitops = {
      source = "cloud-native-toolkit/gitops"
    }

    ibm = {
      source = "ibm-cloud/ibm"
    }

  }
}