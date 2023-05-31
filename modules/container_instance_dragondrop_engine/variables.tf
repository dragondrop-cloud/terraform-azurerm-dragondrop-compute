variable "container_cpu" {
  description = "The number of CPU cores to allocate to the dragondrop container"
  type        = number
  default     = 2
}

variable "container_memory" {
  description = "The amount of memory to allocate to the dragondrop container"
  type        = number
  default     = 8
}

variable "dragondrop_api" {
  description = "URL for the dragondrop API."
  type        = string
}

variable "dragondrop_engine_image" {
  description = "The Docker image to use for the dragondrop engine"
  type        = string
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
