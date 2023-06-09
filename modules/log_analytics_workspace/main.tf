resource "azurerm_log_analytics_workspace" "log_workspace" {
  location                        = var.location
  name                            = "dragondrop-logs"
  resource_group_name             = var.resource_group_name
  sku                             = "PerGB2018"
  retention_in_days               = 30
  allow_resource_only_permissions = true

  daily_quota_gb = 0.5

  tags = merge(
    { origin = "dragondrop-compute-module" },
    var.tags,
  )
}
