##############
#Outputs
##############
output "public_ip" {
  description = "Public IP"
  value       = azurerm_public_ip.publicip.*.ip_address
}