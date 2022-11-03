####################
## Network - Main ##
####################

# Create a Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "${var.region}-${var.environment}-${var.app_name}-rg"
  location = var.location
  tags = {
    environment = var.environment
  }
}

# Create the VNET
resource "azurerm_virtual_network" "vnet" {
  name                = "${var.region}-${var.environment}-${var.app_name}-vnet"
  address_space       = [var.vnet-cidr]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tags = {
    environment = var.environment
  }
}

# Create a Gateway Subnet
resource "azurerm_subnet" "gateway-subnet" {
  name                 = "GatewaySubnet" # do not rename
  address_prefixes     = [var.gateway-subnet-cidr]
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = azurerm_resource_group.rg.name
}
