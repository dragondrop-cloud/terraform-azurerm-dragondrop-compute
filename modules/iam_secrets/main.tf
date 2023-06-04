data "azurerm_client_config" "current" {}

data "azurerm_subscription" "current" {}

resource "azurerm_user_assigned_identity" "container_app" {
  location            = var.location
  name                = "dragondrop-container-app"
  resource_group_name = var.resource_group_name
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
  scope              = var.container_instance_id
  role_definition_id = azurerm_role_definition.example.id
  principal_id       = azurerm_user_assigned_identity.container_app.principal_id
}

# Creating secrets and adding access permission to the managed role
resource "azurerm_key_vault" "secrets" {
  name                = "dragondrop-secrets"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = "standard"
  tenant_id           = data.azurerm_client_config.current.tenant_id

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Create",
      "Get",
      "List",
      "Update",
    ]

    secret_permissions = [
      "Set",
      "Get",
      "List",
    ]
  }


  tags = merge(
    { origin = "dragondrop-compute-module" },
    var.tags,
  )
}

module "division_cloud_credentials" {
  source = "../secret/"

  key_vault_id = azurerm_key_vault.secrets.id
  secret_name  = "DIVISIONCLOUDCREDENTIALS"
  principal_id = azurerm_user_assigned_identity.container_app.principal_id

  tags = var.tags
}

module "infracost_api_token" {
  source = "../secret/"

  key_vault_id = azurerm_key_vault.secrets.id
  secret_name  = "INFRACOSTAPITOKEN"
  principal_id = azurerm_user_assigned_identity.container_app.principal_id

  tags = var.tags
}

module "job_token" {
  source = "../secret/"

  key_vault_id = azurerm_key_vault.secrets.id
  secret_name  = "JOBTOKEN"
  principal_id = azurerm_user_assigned_identity.container_app.principal_id

  tags = var.tags
}

module "terraform_cloud_token" {
  source = "../secret/"

  key_vault_id = azurerm_key_vault.secrets.id
  secret_name  = "TERRAFORMCLOUDTOKEN"
  principal_id = azurerm_user_assigned_identity.container_app.principal_id

  tags = var.tags
}

module "vcs_token" {
  source = "../secret/"

  key_vault_id = azurerm_key_vault.secrets.id
  secret_name  = "VCSTOKEN"
  principal_id = azurerm_user_assigned_identity.container_app.principal_id

  tags = var.tags
}
