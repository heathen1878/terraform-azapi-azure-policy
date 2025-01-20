terraform {
  required_version = "~> 1.0"
  required_providers {
    azurerm  = {
      source = "hashicorp/azurerm"
    }
    azapi = {
      source  = "azure/azapi"
      version = "2.2.0"
    }
  }
}