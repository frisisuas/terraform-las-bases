#######################
# Get external Ip
#######################
data "http" "myExtIP" {
  url = "http://ident.me"
}
#######################
# Account data retrieve
#######################
data "azurerm_client_config" "current" {}

#######################
#Get Keyvault secrets
#######################
data "azurerm_key_vault" "kv" {
  name                = var.keyvault
  resource_group_name = var.rg-keyvault
}
#######################
#Get Keyvault secret admin name
#######################
data "azurerm_key_vault_secret" "kv_admin_name" {
  name         = var.admin_name
  key_vault_id = data.azurerm_key_vault.kv.id
}
#######################
#Get Keyvault secret admin password
#######################
data "azurerm_key_vault_secret" "kv_admin_password" {
  name         = var.admin_password
  key_vault_id = data.azurerm_key_vault.kv.id
}
##############
#disk alternative
##############
resource "azurerm_managed_disk" "disk" {
  name                 = "${azurerm_windows_virtual_machine.vm.name}-disk1"
  location             = azurerm_resource_group.rg.location
  resource_group_name  = azurerm_resource_group.rg.name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = 120
  tags                 = var.default_tags
}

resource "azurerm_virtual_machine_data_disk_attachment" "diskattach" {
  managed_disk_id    = azurerm_managed_disk.disk.id
  virtual_machine_id = azurerm_windows_virtual_machine.vm.id
  lun                = "10"
  caching            = "ReadWrite"
}
##############
#RG
##############
resource "azurerm_resource_group" "rg" {
  name     = "rg-vmsecrets"
  location = "West Europe"
}
#############
# NSG
#############
resource "azurerm_network_security_group" "nsg" {
  location            = var.location
  name                = "NSG"
  resource_group_name = azurerm_resource_group.rg.name
  tags                = var.default_tags
}
resource "azurerm_network_security_rule" "nsg-rule" {
  name                        = "nsg-rdp-rule"
  resource_group_name         = azurerm_resource_group.rg.name
  access                      = "Allow"
  direction                   = "Inbound"
  network_security_group_name = azurerm_network_security_group.nsg.name
  priority                    = 111
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "3389"
  source_address_prefix       = data.http.myExtIP.body
  destination_address_prefix  = "*"
}
#############
#Network
#############
resource "azurerm_virtual_network" "vnetwork" {
  name                = "vNET"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = var.default_tags
}

resource "azurerm_subnet" "subnet" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnetwork.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "publicip" {
  name                = "pip"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Static"
  tags                = var.default_tags
}

resource "azurerm_network_interface" "nic" {
  name                = "nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.publicip.id
  }
  tags = var.default_tags
}


###############
#Virtual Machine
###############
resource "azurerm_windows_virtual_machine" "vm" {
  name                = var.machine_hostname
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = var.machine_size
  admin_username      = data.azurerm_key_vault_secret.kv_admin_name.value
  admin_password      = data.azurerm_key_vault_secret.kv_admin_password.value
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]
  os_disk {
    name                 = "OS-disk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
  tags = var.default_tags
}
