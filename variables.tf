variable "dragondrop_api" {
  description = "URL for the dragondrop API, used for controlling allowed origins on the Lambda URL."
  type        = string
  default     = "https://api.dragondrop.cloud"
}

variable "dragondrop_engine_image" {
  description = "The Docker image to use for the dragondrop engine"
  type        = string
  default     = "us-east4-docker.pkg.dev/dragondrop-prod/dragondrop-engine/engine:latest"
}

variable "env_division_cloud_credentials" {
  description = "The environment containing a map between cloud divisions and the corresponding credential set. For formatting information, see https://docs.dragondrop.cloud/product-docs/deploying-to-your-cloud/environment-variables#scanning-your-cloud-env-vars"
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
