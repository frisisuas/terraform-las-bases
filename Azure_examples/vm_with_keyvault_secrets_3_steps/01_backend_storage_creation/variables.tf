variable "location" {
  description = "Location to deploy resources"
  default     = "westeurope"
}
variable "rg_name" {
  description = "Name of Resource Group"
  default     = "RG-STGTFSTATE"
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
