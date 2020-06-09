variable "resource_group_name" {
  type        = string
  default     = "ResourceGroup-Chapter01"
  description = ""
}

variable "location" {
  type        = string
  default     = "japaneast"
  description = ""
}

variable "virtual_network_name" {
  type        = string
  default     = "VirtualNetwork"
  description = ""
}

variable "web01-vmname" {
  type        = string
  default     = "web01"
  description = ""
}
variable "web01-network_interface_name" {
  type        = string
  default     = "web01-public"
  description = ""
}

variable "web01-securitygroup" {
  type        = string
  default     = "web01-securitygroup"
  description = ""
}

variable "web01-publicip" {
  type        = string
  default     = "web01-publicip"
  description = ""
}

variable "web01-hostname" {
  type        = string
  default     = "web01-hostname"
  description = ""
}

variable "web01-storagename" {
  type        = string
  default     = "web01-sdisk"
  description = ""
}
