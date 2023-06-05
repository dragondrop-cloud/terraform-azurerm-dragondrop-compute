output "https_url" {
  value = azurerm_container_app.dragondrop_https_trigger.ingress[0].fqdn
}
