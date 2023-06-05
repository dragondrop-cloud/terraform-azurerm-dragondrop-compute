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
  scope              = var.container_instance_id
  role_definition_id = azurerm_role_definition.example.role_definition_id
  principal_id       = azurerm_user_assigned_identity.container_app.principal_id
}

# Creating the key vault and adding access permission to access/update the secrets
resource "azurerm_key_vault" "secrets" {
  name                = "dragondrop-secrets"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = "standard"
  tenant_id           = data.azurerm_client_config.current.tenant_id

  tags = merge(
    { origin = "dragondrop-compute-module" },
    var.tags,
  )
}

## Permissions for managed identity to access the key vault
resource "azurerm_key_vault_access_policy" "user_assigned_identity" {
  key_vault_id = azurerm_key_vault.secrets.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = azurerm_user_assigned_identity.container_app.principal_id

  key_permissions = [
    "Get",
    "List",
  ]

  secret_permissions = [
    "Get",
    "List",
  ]
}

## Permissions for terraform client to access the key vault
resource "azurerm_key_vault_access_policy" "terraform_client" {
  key_vault_id = azurerm_key_vault.secrets.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

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

## Permissions for a principal account to access the key vault
resource "azurerm_key_vault_access_policy" "console_user" {
  key_vault_id = azurerm_key_vault.secrets.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = var.user_object_id_to_access_key_vault

  key_permissions = [
    "Create",
    "Get",
    "List",
    "Update",
    "Delete"
  ]

  secret_permissions = [
    "Set",
    "Get",
    "List",
    "Delete"
  ]
}

# Adding secrets to the key vault
module "division_cloud_credentials" {
  source = "../secret/"

  key_vault_id = azurerm_key_vault.secrets.id
  secret_name  = "DIVISIONCLOUDCREDENTIALS"
  tags         = var.tags
}

module "infracost_api_token" {
  source = "../secret/"

  key_vault_id = azurerm_key_vault.secrets.id
  secret_name  = "INFRACOSTAPITOKEN"
  tags         = var.tags
}

module "job_token" {
  source = "../secret/"

  key_vault_id = azurerm_key_vault.secrets.id
  secret_name  = "JOBTOKEN"
  tags         = var.tags
}

module "terraform_cloud_token" {
  source = "../secret/"

  key_vault_id = azurerm_key_vault.secrets.id
  secret_name  = "TERRAFORMCLOUDTOKEN"
  tags         = var.tags
}

module "vcs_token" {
  source = "../secret/"

  key_vault_id = azurerm_key_vault.secrets.id
  secret_name  = "VCSTOKEN"
  tags         = var.tags
}
