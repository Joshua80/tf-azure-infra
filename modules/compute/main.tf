
resource "azurerm_service_plan" "web" {
  name                = var.service_plan_name
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = "Windows"
  sku_name            = var.app_service_sku
}

resource "azurerm_windows_web_app" "web" {
  name                = var.webapp_name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.web.id
  site_config {
    always_on = var.always_on
  }
  app_settings = var.app_settings
}
