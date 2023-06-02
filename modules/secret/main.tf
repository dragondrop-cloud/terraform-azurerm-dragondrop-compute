resource "azurerm_key_vault_secret" "secret" {
  name         = "DRAGONDROP_${var.secret_name}"
  value        = "placeholder"
  key_vault_id = var.key_vault_id

  tags = merge(
    { origin = "dragondrop-compute-module" },
    var.tags,
  )
}

resource "azurerm_role_assignment" "container_app" {
  scope                = azurerm_key_vault_secret.secret.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = var.principal_id
}
