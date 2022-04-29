resource "random_string" "resource_code" {
  length  = 5
  special = false
  upper   = false
}

resource "azurerm_resource_group" "rg" {
  name     = "aztfstate"
  location = "westeurope"
}

resource "azurerm_storage_account" "stgacc" {
  name                              = "tfstate${random_string.resource_code.result}"
  resource_group_name               = azurerm_resource_group.rg.name
  location                          = azurerm_resource_group.rg.location
  account_tier                      = "Standard"
  account_replication_type          = "LRS"
  allow_blob_public_access          = true
  infrastructure_encryption_enabled = true
  blob_properties {
    versioning_enabled = true
  }
  network_rules {
    bypass         = ["AzureServices"]
    default_action = "Allow"
  }
  min_tls_version = "TLS1_2"
  tags = {
    environment = "development"
  }
}

resource "azurerm_storage_container" "stgcnt" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.stgacc.name
  container_access_type = "blob"
}
