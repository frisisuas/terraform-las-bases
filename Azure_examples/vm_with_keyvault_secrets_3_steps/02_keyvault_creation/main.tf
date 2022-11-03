resource "random_string" "random" {
  length  = 5
  lower   = true
  special = false
}

data "azurerm_client_config" "current" {}
locals {
  current_timestamp = timestamp()
  current_day       = formatdate("DD-MM-YYYY", local.current_timestamp)
  current_time      = formatdate("hh:mm:ss", local.current_timestamp)
  current_day_name  = formatdate("EEEE", local.current_timestamp)
}
resource "azurerm_resource_group" "rg_kv" {
  location = var.location
  name     = var.rg_name
  tags = merge(
    var.default_tags,
    {
      CreationDay = local.current_day
    },
  )
}
