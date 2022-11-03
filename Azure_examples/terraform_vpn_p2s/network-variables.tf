#########################
## Network - Variables ##
#########################

variable "vnet-cidr" {
  type        = string
  description = "The CIDR of the VNET"
}

variable "gateway-subnet-cidr" {
  type        = string
  description = "The CIDR for the Gateway subnet"
}
