##############
#variables
##############

variable "machine_hostname" {
  description = "Virtual Machine Hostname"
  type        = string
}

variable "machine_size" {
  description = "Virtual Machine Size"
  type        = string
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
variable "location" {
  type    = string
  default = "West Europe"
}
variable "subscription" {
  default = ""
}

variable "keyvault" {
  default = ""
}

variable "rg-keyvault" {
  default = ""
}

variable "admin_name" {
  default = ""
}
variable "admin_password" {
  default = ""
}
variable "stgacc_sas" {
  default = ""
}