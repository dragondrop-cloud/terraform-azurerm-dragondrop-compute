output "container_instance_id" {
  value = module.container_instance_dragondrop_engine.container_instance_id
}

output "https_url" {
  value = module.container_app_https_endpoint.https_url
}

output "log_analytics_container_app_query" {
  value = module.container_app_https_endpoint.log_analytics_container_app_query
}
