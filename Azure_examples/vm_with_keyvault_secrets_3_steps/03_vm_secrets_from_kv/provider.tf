terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.94.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "XXXXXXXXXXXXX"	//Replace it
    storage_account_name = "XXXXXXXXXXXXX"	//Replace it
    container_name       = "tfstate"
    key                  = "DEV/compute/terraform.tfstate"
  }
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
}
data "terraform_remote_state" "remote_tfstate" {

  backend = "azurerm"
  config = {
    resource_group_name  = "XXXXXXXXXXXXX"  //Replace it
    storage_account_name = "XXXXXXXXXXXXX"  //Replace it
    container_name       = "tfstate"
    key                  = "DEV/terraform.tfstate"
  }
}


