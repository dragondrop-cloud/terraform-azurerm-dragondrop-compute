output "https_url" {
  value = module.container_app_https_endpoint.https_url
}

output "container_instance_id" {
  value = module.container_instance_dragondrop_engine.container_instance_id
}
