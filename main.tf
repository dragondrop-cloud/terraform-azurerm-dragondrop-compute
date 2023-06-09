module "log_analytics_workspace" {
  source = "./modules/log_analytics_workspace"

  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags
}

module "container_instance_dragondrop_engine" {
  source = "./modules/container_instance_dragondrop_engine"

  dragondrop_api              = var.dragondrop_api
  dragondrop_engine_image     = var.dragondrop_engine_image
  log_analytics_workspace_id  = module.log_analytics_workspace.log_analytics_workspace_id
  log_analytics_workspace_key = module.log_analytics_workspace.log_analytics_workspace_key

  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags

  depends_on = [module.log_analytics_workspace]
}

module "iam_secrets" {
  source = "./modules/iam_secrets"

  container_instance_id = module.container_instance_dragondrop_engine.container_instance_id
  custom_role_name      = var.custom_role_name
  resource_group_name   = var.resource_group_name
  location              = var.location
  tags                  = var.tags
}

module "container_app_https_endpoint" {
  source = "./modules/container_app_https_endpoint"

  dragondrop_api                           = var.dragondrop_api
  dragondrop_https_trigger_container_image = var.dragondrop_https_trigger_container_image
  log_analytics_workspace_id               = module.log_analytics_workspace.log_analytics_workspace_id

  container_app_identity_client_id = module.iam_secrets.container_app_identity_client_id
  container_app_identity_id        = module.iam_secrets.container_app_identity_id
  container_instance_id            = module.container_instance_dragondrop_engine.container_instance_id
  resource_group_name              = var.resource_group_name
  location                         = var.location
  tags                             = var.tags

  depends_on = [module.container_instance_dragondrop_engine, module.log_analytics_workspace]
}
