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

resource "azurerm_container_app" "dragondrop_https_trigger" {
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
    target_port                = 50505

    traffic_weight {
      percentage      = 100
      latest_revision = true
    }
  }

  secret {
    name  = "division-cloud-credentials"
    value = "placeholder"
  }

  secret {
    name  = "infracost-api-token"
    value = "placeholder"
  }

  secret {
    name  = "job-token"
    value = "placeholder"
  }

  secret {
    name  = "terraform-cloud-token"
    value = "placeholder"
  }

  secret {
    name  = "vcs-token"
    value = "placeholder"
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
        secret_name = "division-cloud-credentials"
      }

      env {
        name        = "DRAGONDROP_INFRACOSTAPITOKEN"
        secret_name = "infra-cost-api-token"
      }

      env {
        name        = "DRAGONDROP_JOBTOKEN"
        secret_name = "job-token"
      }

      env {
        name        = "DRAGONDROP_TERRAFORMCLOUDTOKEN"
        secret_name = "terraform-cloud-token"
      }

      env {
        name        = "DRAGONDROP_VCSTOKEN"
        secret_name = "vcs-token"
      }
    }
  }

  tags = merge(
    { origin = "dragondrop-compute-module" },
    var.tags,
  )
  depends_on = [azurerm_container_app_environment.container_environment]
}
