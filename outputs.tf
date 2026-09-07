output "resource_group_name" {
  description = "Resource group that contains the platform."
  value       = azurerm_resource_group.platform.name
}

output "container_app_fqdn" {
  description = "HTTPS endpoint of the reference Container App."
  value       = module.container_platform.fqdn
}

output "container_registry_login_server" {
  description = "Private Azure Container Registry login server."
  value       = module.registry.login_server
}

output "key_vault_uri" {
  description = "Private Key Vault URI."
  value       = module.key_vault.uri
}

output "workload_identity_client_id" {
  description = "Client ID used by workloads for passwordless Azure authentication."
  value       = azurerm_user_assigned_identity.workload.client_id
}
