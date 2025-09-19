variable "app_service_plan_id" {
  description = "ID of the App Service plan"
  type        = string
  
}

variable "webapp_name" {
  description = "Name of the Web App"
  type        = string
  
}

variable "resource_group_name" {
  description = "Resource group name for the Web App"
  type        = string
  
}

variable "location" {
  description = "Azure region for the Web App"
  type        = string
  
}

variable "always_on" {
  description = "Whether the Web App should be always on"
  type        = bool
  default     = true
  
}

variable "app_settings" {
  description = "App settings for the Web App"
  type        = map(string)
  default     = {}
  
}

variable "app_service_subnet_id" {
  description = "Subnet ID for the App Service"
  type        = string
  default     = null
  
}