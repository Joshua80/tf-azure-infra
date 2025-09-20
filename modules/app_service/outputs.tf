
output "app_insights_instrumentation_key" {
	description = "Instrumentation Key for Application Insights"
	value       = azurerm_application_insights.appinsights.instrumentation_key
}

output "app_insights_connection_string" {
	description = "Connection string for Application Insights"
	value       = azurerm_application_insights.appinsights.connection_string
}
