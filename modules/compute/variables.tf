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
  default     = "Linux"
}

variable "app_service_sku" {
  description = "SKU for App Service plan"
  type        = string
  default     = "B1"
}

variable "webapp_name" {
  description = "Name of the web app"
  type        = string
}

variable "always_on" {
  description = "Enable always on for web app"
  type        = bool
  default     = true
}

variable "app_settings" {
  description = "App settings for the web app"
  type        = map(string)
  default     = {}
}

variable "app_service_subnet_id" {
  description = "The ID of the subnet to which the App Service will be connected"
  type        = string
  
}
