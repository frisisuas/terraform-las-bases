resource "azurerm_linux_virtual_machine" "VM" {
  name = "vm-apache"
  location              = var.location
  network_interface_ids = [
    azurerm_network_interface.nic.id
    ]
  resource_group_name   = azurerm_resource_group.rg.name
  size = "Standard_B1s"
  admin_username = var.admin_username
  admin_password = var.admin_password
  disable_password_authentication = false
  os_disk {
    name              = "VM-OS-Disk"
    caching           = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
  boot_diagnostics {
    
  }
}