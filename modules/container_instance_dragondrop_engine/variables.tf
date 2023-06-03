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

variable "log_analytics_workspace_id" {
  description = "The id of the log analytics workspace to which to send logs"
  type        = string
}

variable "log_analytics_workspace_key" {
  description = "The key of the log analytics workspace to which to send logs"
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
