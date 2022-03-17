variable "location" {
  description = "Location to deploy resources"
  default     = "westeurope"
}
variable "rg_name" {
  description = "Name of Resource Group"
  default     = "rg-keyvault"
}
variable "kv_name" {
  description = "Key Vault Name (Global unique name)"
  default     = ""
}
variable "admin_name" {
  default = "" // leave it empty
}
variable "admin_password" {
  default = "" // leave it empty
}
variable "subscription_id" {
  default = ""
}
variable "default_tags" {
  default = {

    Environment = "Development"
    DeployedBy  = "Terraform"
    Project     = "LearningTerraform"
  }
  description = "Default Tags"
  type        = map(string)
}