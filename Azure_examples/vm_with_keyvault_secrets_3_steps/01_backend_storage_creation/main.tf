data "azurerm_client_config" "current" {}
locals {
  current_timestamp = timestamp()
  current_day       = formatdate("DD-MM-YYYY", local.current_timestamp)
  current_time      = formatdate("hh:mm:ss", local.current_timestamp)
  current_day_name  = formatdate("EEEE", local.current_timestamp)
}
resource "random_string" "resource_code" {
  length  = 5
  special = false
  upper   = false
}
resource "azurerm_resource_group" "rg" {
  location = var.location
  name     = var.rg_name
}

resource "azurerm_storage_account" "stgacc" {
  name                     = "tfstate${random_string.resource_code.result}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  allow_blob_public_access = true
  blob_properties {
    versioning_enabled = true
  }
  network_rules {
    bypass         = ["AzureServices"]
    default_action = "Allow"
  }
  min_tls_version = "TLS1_2"
  tags = merge(
    var.default_tags,
    {
      CreationDay = local.current_day
    },
  )
}

resource "azurerm_storage_container" "stgcnt" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.stgacc.name
  container_access_type = "blob"
}