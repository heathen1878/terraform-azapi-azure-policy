terraform {
  required_version = "~> 1.0"
  required_providers {
    azapi = {
      source  = "azure/azapi"
      version = ">= 1.14.0, <= 2.2.0"
    }
  }
}