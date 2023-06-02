resource "azurerm_container_group" "azure_container_instance" {
  location            = var.location
  name                = "dragondrop_engine_container"
  os_type             = "Linux"
  resource_group_name = var.resource_group_name
  restart_policy      = "Never"
  ip_address_type     = "None"

  container {
    cpu    = var.container_cpu
    image  = var.dragondrop_engine_image
    memory = var.container_memory
    name   = "dragondrop-engine-container-instance"

    ports {
      port     = 80
      protocol = "TCP"
    }
  }

  diagnostics {
    log_analytics {
      workspace_id  = var.log_analytics_workspace_id
      workspace_key = var.log_analytics_workspace_key
    }
  }

  identity {
    type = "SystemAssigned"
  }

  tags = merge(
    { origin = "dragondrop-compute-module" },
    var.tags,
  )
}
