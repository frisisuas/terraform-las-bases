###########################
## Azure Provider - Main ##
###########################


terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.29.1"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features {}
}

data "azurerm_client_config" "current" {}