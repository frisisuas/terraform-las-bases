terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.94.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "aztfstate"
    storage_account_name = "tfstatee793h"
    container_name       = "tfstate"
    key                  = "web.tfstate"
  }

}

provider "azurerm" {
  features {}
}