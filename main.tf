module "container_instance_dragondrop_engine" {
  source = "./modules/container_instance_dragondrop_engine"

  dragondrop_api                 = var.dragondrop_api
  dragondrop_engine_image        = var.dragondrop_engine_image
  env_division_cloud_credentials = var.env_division_cloud_credentials
  resource_group_name            = var.resource_group_name
  location                       = var.location
  tags                           = var.tags
}

module "container_app_https_endpoint" {
  source = "./modules/container_app_https_endpoint"

  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags

  depends_on = [module.container_instance_dragondrop_engine]
}
