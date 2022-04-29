data "terraform_remote_state" "networking" {
  backend = "azurerm"
  config = {
    resource_group_name  = "aztfstate"
    storage_account_name = "REPLACE"
    container_name       = "tfstate"
    key                  = "networking.tfstate"
  }
}
