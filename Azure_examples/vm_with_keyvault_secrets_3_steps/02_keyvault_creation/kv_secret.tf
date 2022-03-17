resource "azurerm_key_vault_secret" "kv_admin_user" {
  key_vault_id = azurerm_key_vault.kv.id
  name         = "admin-name"
  value        = var.admin_name
}
resource "azurerm_key_vault_secret" "kv_admin_password" {
  key_vault_id = azurerm_key_vault.kv.id
  name         = "admin-password"
  value        = var.admin_password
}