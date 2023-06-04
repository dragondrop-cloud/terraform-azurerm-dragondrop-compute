resource "azurerm_container_app_environment" "container_environment" {
  name                       = "dragondrop-container-environment"
  location                   = var.location
  resource_group_name        = var.resource_group_name
  log_analytics_workspace_id = var.log_analytics_workspace_id

  tags = merge(
    { origin = "dragondrop-compute-module" },
    var.tags,
  )
}

# TODO: Enable HTTPS ingress and get the https endpoint value out of it -- Exact process to be determined
# TODO: Partly from environment IP address
resource "azurerm_container_app" "example" {
  name                         = "dragondrop-https-trigger"
  container_app_environment_id = azurerm_container_app_environment.container_environment.id
  resource_group_name          = var.resource_group_name

  revision_mode = "Single"

  identity {
    type = "UserAssigned"
    identity_ids = [
      var.container_app_identity_id
    ]
  }


  ingress {
    allow_insecure_connections = false
    external_enabled           = true
    target_port                = 443

    traffic_weight {
      percentage      = 100
      latest_revision = true
    }
  }

  template {
    max_replicas = 2
    min_replicas = 0

    container {
      name   = "dragondrop-https-trigger-container"
      cpu    = 1.0
      memory = "2Gi"
      image  = var.dragondrop_https_trigger_container_image

      env {
        name  = "RESOURCE_GROUP"
        value = var.resource_group_name
      }

      env {
        name  = "CONTAINER_GROUP_ID"
        value = var.container_app_identity_id
      }

      env {
        name        = "DRAGONDROP_DIVISIONCLOUDCREDENTIALS"
        secret_name = var.division_cloud_credentials_secret_id
      }

      env {
        name        = "DRAGONDROP_INFRACOSTAPITOKEN"
        secret_name = var.infracost_api_token_secret_id
      }

      env {
        name        = "DRAGONDROP_JOBTOKEN"
        secret_name = var.job_token_secret_id
      }

      env {
        name        = "DRAGONDROP_TERRAFORMCLOUDTOKEN"
        secret_name = var.terraform_cloud_token_secret_id
      }

      env {
        name        = "DRAGONDROP_VCSTOKEN"
        secret_name = var.vcs_token_secret_id
      }
    }
  }

  tags = merge(
    { origin = "dragondrop-compute-module" },
    var.tags,
  )
  depends_on = [azurerm_container_app_environment.container_environment]
}
