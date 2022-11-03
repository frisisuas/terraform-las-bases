#####################
## KeyVault - Main ##
#####################

# Create the Azure Key Vault - globally unique - 24 characters max
resource "azurerm_key_vault" "keyvault" {
  name                = "${var.region}-${var.environment}-${var.app_name}-kv"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  enabled_for_deployment          = var.kv-enabled-for-deployment
  enabled_for_disk_encryption     = var.kv-enabled-for-disk-encryption
  enabled_for_template_deployment = var.kv-enabled-for-template-deployment
  tenant_id                       = data.azurerm_client_config.current.tenant_id

  sku_name = var.kv-sku-name

  tags = {
    environment = var.environment
  }

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    certificate_permissions = var.kv-certificate-permissions-full
    key_permissions         = var.kv-key-permissions-full
    secret_permissions      = var.kv-secret-permissions-full
    storage_permissions     = var.kv-storage-permissions-full
  }

  network_acls {
    default_action = "Allow"
    bypass         = "AzureServices"
  }
}