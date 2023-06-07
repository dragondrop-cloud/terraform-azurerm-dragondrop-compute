output "container_app_identity_id" {
  value = azurerm_user_assigned_identity.container_app.id
}

output "container_app_identity_client_id" {
  value = azurerm_user_assigned_identity.container_app.client_id
}
