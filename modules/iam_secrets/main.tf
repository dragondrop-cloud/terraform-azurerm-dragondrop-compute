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

data "azurerm_role_definition" "dragondrop_custom_role" {
  count = var.create_custom_role ? 0 : 1
  name  = "dragondrop-container-instance-update"
  scope = data.azurerm_subscription.current.id
}

resource "azurerm_role_definition" "example" {
  count       = var.create_custom_role ? 1 : 0
  name        = "dragondrop-container-instance-update"
  scope       = data.azurerm_subscription.current.id
  description = "Custom role for ability to update or create a container instance container group."

  permissions {
    actions = [
      "Microsoft.ContainerInstance/containerGroups/read",
      "Microsoft.ContainerInstance/containerGroups/write",
    ]
    not_actions = []
  }

  assignable_scopes = [
    data.azurerm_subscription.current.id,
  ]
}

resource "azurerm_role_assignment" "container_app" {
  scope              = data.azurerm_subscription.current.id
  role_definition_id = var.create_custom_role ? azurerm_role_definition.example.role_definition_resource_id : data.azurerm_role_definition.dragondrop_custom_role.id
  principal_id       = azurerm_user_assigned_identity.container_app.principal_id
}
