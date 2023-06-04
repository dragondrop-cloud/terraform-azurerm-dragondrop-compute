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

  identity {
    type = "SystemAssigned"
  }

  tags = merge(
    { origin = "dragondrop-compute-module" },
    var.tags,
  )
}
