data "azurerm_client_config" "current" {}

data "azurerm_subscription" "current" {}

resource "azurerm_user_assigned_identity" "container_app" {
  location            = var.location
  name                = "dragondrop-container-app"
  resource_group_name = var.resource_group_name

  tags = merge(
    { origin = "dragondrop-compute-module" },
    var.tags,
  )
}

resource "azurerm_role_definition" "example" {
  name        = "dragondrop-container-instance-update"
  scope       = data.azurerm_subscription.current.id
  description = "Custom role for ability to update or create a container instance container group."

  permissions {
    actions     = ["Microsoft.ContainerInstance/containerGroups/write"]
    not_actions = []
  }

  assignable_scopes = [
    data.azurerm_subscription.current.id,
  ]
}

resource "azurerm_role_assignment" "container_app" {
  scope              = data.azurerm_subscription.current.id
  role_definition_id = azurerm_role_definition.example.role_definition_id
  principal_id       = azurerm_user_assigned_identity.container_app.principal_id
}
