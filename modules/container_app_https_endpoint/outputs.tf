output "https_url" {
  value = azurerm_container_app.dragondrop_https_trigger.ingress[0].fqdn
}

output "log_analytics_container_app_query" {
  value = "ContainerAppConsoleLogs_CL | where EnvironmentName_s == '${azurerm_container_app_environment.container_environment.name}' | project _timestamp_d, ContainerName_s, EnvironmentName_s, Log_s | order by _timestamp_d"
}
