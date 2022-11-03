#############################
# Azure Key Vault variables #
#############################
/*
variable "kv-full-object-id" {
  type        = string
  description = "The object ID of a user, service principal or security group in the Azure Active Directory tenant for FULL access to the Azure Key Vault"

}
*/
variable "kv-sku-name" {
  type        = string
  description = "Select Standard or Premium SKU"
  default     = "standard"
}

variable "kv-enabled-for-deployment" {
  type        = string
  description = "Allow Azure Virtual Machines to retrieve certificates stored as secrets from the Azure Key Vault"
  default     = "true"
}

variable "kv-enabled-for-disk-encryption" {
  type        = string
  description = "Allow Azure Disk Encryption to retrieve secrets from the Azure Key Vault and unwrap keys"
  default     = "true"
}

variable "kv-enabled-for-template-deployment" {
  type        = string
  description = "Allow Azure Resource Manager to retrieve secrets from the Azure Key Vault"
  default     = "true"
}

variable "kv-key-permissions-full" {
  type        = list(string)
  description = "List of full key permissions, must be one or more from the following: backup, create, decrypt, delete, encrypt, get, import, list, purge, recover, restore, sign, unwrapKey, update, verify and wrapKey."
  default = ["Backup", "Create", "Decrypt", "Delete", "Encrypt", "Get", "Import", "List", "Purge",
  "Recover", "Restore", "Sign", "UnwrapKey", "Update", "Verify", "WrapKey"]
}

variable "kv-secret-permissions-full" {
  type        = list(string)
  description = "List of full secret permissions, must be one or more from the following: backup, delete, get, list, purge, recover, restore and set"
  default     = ["Backup", "Delete", "Get", "List", "Purge", "Recover", "Restore", "Set"]
}

variable "kv-certificate-permissions-full" {
  type        = list(string)
  description = "List of full certificate permissions, must be one or more from the following: backup, create, delete, deleteissuers, get, getissuers, import, list, listissuers, managecontacts, manageissuers, purge, recover, restore, setissuers and update"
  default = ["Create", "Delete", "DeleteIssuers", "Get", "GetIssuers", "Import", "List", "ListIssuers",
  "ManageContacts", "ManageIssuers", "Purge", "Recover", "SetIssuers", "Update", "Backup", "Restore"]
}

variable "kv-storage-permissions-full" {
  type        = list(string)
  description = "List of full storage permissions, must be one or more from the following: backup, delete, deletesas, get, getsas, list, listsas, purge, recover, regeneratekey, restore, set, setsas and update"
  default = ["Backup", "Delete", "DeleteSAS", "Get", "GetSAS", "List", "ListSAS",
  "Purge", "Recover", "RegenerateKey", "Restore", "Set", "SetSAS", "Update"]
}
