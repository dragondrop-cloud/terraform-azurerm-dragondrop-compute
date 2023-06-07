variable "container_app_identity_id" {
  description = "The id of the identity to assign to the container app service"
  type        = string
}

variable "container_app_identity_client_id" {
  description = "The client id of the identity to assign to the container app service"
  type        = string
}

variable "container_instance_id" {
  description = "The id of the container instance to be triggered by the container app."
  type        = string
}

variable "dragondrop_https_trigger_container_image" {
  description = "Path to the dragondrop engine container used in the container app service as the https endpoint."
  type        = string
}

variable "log_analytics_workspace_id" {
  description = "The id of the log analytics workspace to which to send logs"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the resources"
  type        = string
}

variable "location" {
  description = "The Azure Region in which to create the resources"
  type        = string
}

variable "tags" {
  description = "A mapping of tags to assign to append to all created resources"
  type        = map(string)
}
