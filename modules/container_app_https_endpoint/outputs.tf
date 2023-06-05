output "https_url" {
  value = azurerm_container_app.dragondrop_https_trigger.ingress[0].fqdn
}

locals {
  environment_identifier_log_analytics = split(".", azurerm_container_app_environment.container_environment.default_domain)[0]
}

output "log_analytics_container_app_query" {
  value = "ContainerAppConsoleLogs_CL | where EnvironmentName_s == '${local.environment_identifier_log_analytics}' | project _timestamp_d, ContainerName_s, EnvironmentName_s, Log_s | order by _timestamp_d"
}
