output "container_app_identity_id" {
  value = azurerm_user_assigned_identity.container_app.id
}

output "division_cloud_credentials_secret_id" {
  value = module.division_cloud_credentials.key_vault_secret_id
}

output "infracost_api_token_secret_id" {
  value = module.infracost_api_token.key_vault_secret_id
}

output "job_token_secret_id" {
  value = module.job_token.key_vault_secret_id
}

output "terraform_cloud_token_secret_id" {
  value = module.terraform_cloud_token.key_vault_secret_id
}

output "vcs_token_secret_id" {
  value = module.vcs_token.key_vault_secret_id
}
