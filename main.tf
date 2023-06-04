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

  user_principal_name_to_access_key_vault = var.user_principal_name_to_access_key_vault
  container_instance_id          = module.container_instance_dragondrop_engine.container_instance_id
  resource_group_name            = var.resource_group_name
  location                       = var.location
  tags                           = var.tags
}

module "container_app_https_endpoint" {
  source = "./modules/container_app_https_endpoint"

  dragondrop_https_trigger_container_image = var.dragondrop_https_trigger_container_image
  log_analytics_workspace_id               = module.log_analytics_workspace.log_analytics_workspace_id

  container_app_identity_id            = module.iam_secrets.container_app_identity_id
  division_cloud_credentials_secret_id = module.iam_secrets.division_cloud_credentials_secret_id
  infracost_api_token_secret_id        = module.iam_secrets.infracost_api_token_secret_id
  job_token_secret_id                  = module.iam_secrets.job_token_secret_id
  terraform_cloud_token_secret_id      = module.iam_secrets.terraform_cloud_token_secret_id
  vcs_token_secret_id                  = module.iam_secrets.vcs_token_secret_id

  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags

  depends_on = [module.container_instance_dragondrop_engine, module.log_analytics_workspace]
}
