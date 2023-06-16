variable "container_instance_id" {
  description = "The ID of the container instance for which to grant edit permissions."
  type        = string
}

variable "custom_role_name" {
  description = "Name of the custom role."
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
