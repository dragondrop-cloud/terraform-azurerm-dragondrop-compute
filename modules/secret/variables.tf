variable "key_vault_id" {
  description = "The key vault id within which the secret should be created."
  type        = string
}

variable "secret_name" {
  description = "The secret name of the secret to be created."
  type        = string
}

variable "tags" {
  description = "A mapping of tags to assign to append to all created resources."
  type        = map(string)
}
