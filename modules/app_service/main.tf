

# Application Insights
resource "azurerm_application_insights" "appinsights" {
  name                = "${var.webapp_name}-ai"
  location            = var.location
  resource_group_name = var.resource_group_name
  application_type    = "web"
}

resource "azurerm_windows_web_app" "web" {
  name                = var.webapp_name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = var.app_service_plan_id
  site_config  {
    always_on = var.always_on
  }
  app_settings = merge(
    var.app_settings,
    {
      "APPINSIGHTS_INSTRUMENTATIONKEY" = azurerm_application_insights.appinsights.instrumentation_key
      "APPLICATIONINSIGHTS_CONNECTION_STRING" = azurerm_application_insights.appinsights.connection_string
    }
  )
  virtual_network_subnet_id = var.app_service_subnet_id
}
