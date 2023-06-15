variable "container_instance_id" {
  description = "The ID of the container instance for which to grant edit permissions."
  type        = string
}

variable "create_custom_role" {
  description = "Whether to create a custom role for the container instance."
  type        = bool
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
