output "log_analytics_workspace_id" {
  value = azurerm_log_analytics_workspace.log_workspace.id
}

output "log_analytics_workspace_key" {
  value = azurerm_log_analytics_workspace.log_workspace.primary_shared_key
}
