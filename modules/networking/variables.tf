variable "resource_group_name" {
  description = "Resource group name for networking resources"
  type        = string
}

variable "location" {
  description = "Azure region for resources"
  type        = string
}

variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
}

variable "vnet_address_space" {
  description = "Address space for the virtual network"
  type        = list(string)
}

variable "web_subnet_name" {
  description = "Name of the web subnet"
  type        = string
}

variable "web_subnet_address_prefixes" {
  description = "Address prefixes for the web subnet"
  type        = list(string)
}

variable "pe_subnet_name" {
  description = "Name of the database subnet"
  type        = string
}

variable "pe_subnet_address_prefixes" {
  description = "Address prefixes for the private endpoint subnet"
  type        = list(string)
}