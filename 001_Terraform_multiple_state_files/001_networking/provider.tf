terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.94.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "aztfstate"
    storage_account_name = "REPLACE"
    container_name       = "tfstate"
    key                  = "networking.tfstate"
  }

}

provider "azurerm" {
  features {}
}
