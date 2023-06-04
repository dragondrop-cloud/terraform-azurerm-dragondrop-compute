resource "azurerm_key_vault_secret" "secret" {
  name         = "DRAGONDROP-${var.secret_name}"
  value        = "placeholder"
  key_vault_id = var.key_vault_id

  tags = merge(
    { origin = "dragondrop-compute-module" },
    var.tags,
  )
}
