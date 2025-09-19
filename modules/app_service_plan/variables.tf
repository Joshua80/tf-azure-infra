variable "resource_group_name" {
  description = "Resource group name for compute resources"
  type        = string
}

variable "location" {
  description = "Azure region for resources"
  type        = string
}

variable "service_plan_name" {
  description = "Name of the App Service plan"
  type        = string
}

variable "os_type" {
  description = "OS type for App Service plan (Linux/Windows)"
  type        = string
  default     = "Windows"
}

variable "app_service_sku" {
  description = "SKU for App Service plan"
  type        = string
  default     = "B1"
}