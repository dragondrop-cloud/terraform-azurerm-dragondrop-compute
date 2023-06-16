variable "dragondrop_api" {
  description = "URL for the dragondrop API, used for controlling allowed origins on the Lambda URL."
  type        = string
  default     = "https://api.dragondrop.cloud"
}

variable "dragondrop_https_trigger_container_image" {
  description = "Path to the dragondrop engine container used in the container app service as the https endpoint."
  type        = string
  default     = "us-east4-docker.pkg.dev/dragondrop-prod/dragondrop-https-triggers/container-app-service:latest"
}

variable "dragondrop_engine_image" {
  description = "The Docker image to use for the dragondrop engine"
  type        = string
  default     = "us-east4-docker.pkg.dev/dragondrop-prod/dragondrop-engine/engine:latest"
}

variable "custom_role_name" {
  description = "Name of the custom role."
  type        = string
  default     = "dragondrop-container-instance-update"
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
