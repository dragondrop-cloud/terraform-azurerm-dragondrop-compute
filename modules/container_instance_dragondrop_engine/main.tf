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

    secure_environment_variables = {
      "DRAGONDROP_DIVISIONCLOUDCREDENTIALS" = var.env_division_cloud_credentials
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
