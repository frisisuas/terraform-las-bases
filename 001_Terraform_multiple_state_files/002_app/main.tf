resource "azurerm_resource_group" "rg" {
  location = var.location
  name     = "WebApp"
}

resource "azurerm_network_interface" "nic" {
  location            = var.location
  name                = "Nic-Vm-WebApp"
  resource_group_name = azurerm_resource_group.rg.name
  ip_configuration {
    name                          = "PrivateIpWebApp"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip.id
    subnet_id                     = data.terraform_remote_state.networking.outputs.subnet_hub_id
  }
}

resource "azurerm_public_ip" "pip" {
  location            = var.location
  name                = "PublicIpWebApp"
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
  sku                 = "Basic"
}