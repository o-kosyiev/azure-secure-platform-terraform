data "azurerm_client_config" "current" {}

resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}

resource "azurerm_resource_group" "platform" {
  name     = "rg-${local.name_prefix}-${random_string.suffix.result}"
  location = var.location
  tags     = local.common_tags
}

module "networking" {
  source = "./modules/networking"

  name_prefix         = local.name_prefix
  location            = azurerm_resource_group.platform.location
  resource_group_name = azurerm_resource_group.platform.name
  vnet_cidr           = var.vnet_cidr
  tags                = local.common_tags
}

module "observability" {
  source = "./modules/observability"

  name_prefix         = local.name_prefix
  location            = azurerm_resource_group.platform.location
  resource_group_name = azurerm_resource_group.platform.name
  tags                = local.common_tags
}

resource "azurerm_user_assigned_identity" "workload" {
  name                = "id-${local.name_prefix}-workload"
  location            = azurerm_resource_group.platform.location
  resource_group_name = azurerm_resource_group.platform.name
  tags                = local.common_tags
}

module "key_vault" {
  source = "./modules/key_vault"

  name_prefix                = local.name_prefix
  unique_suffix              = random_string.suffix.result
  location                   = azurerm_resource_group.platform.location
  resource_group_name        = azurerm_resource_group.platform.name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  workload_principal_id      = azurerm_user_assigned_identity.workload.principal_id
  private_endpoint_subnet_id = module.networking.private_endpoint_subnet_id
  private_dns_zone_id        = module.networking.private_dns_zone_ids["key_vault"]
  log_analytics_workspace_id = module.observability.log_analytics_workspace_id
  tags                       = local.common_tags
}

module "registry" {
  source = "./modules/registry"

  name_prefix                = local.name_prefix
  unique_suffix              = random_string.suffix.result
  location                   = azurerm_resource_group.platform.location
  resource_group_name        = azurerm_resource_group.platform.name
  private_endpoint_subnet_id = module.networking.private_endpoint_subnet_id
  private_dns_zone_id        = module.networking.private_dns_zone_ids["container_registry"]
  log_analytics_workspace_id = module.observability.log_analytics_workspace_id
  tags                       = local.common_tags
}

resource "azurerm_role_assignment" "workload_acr_pull" {
  scope                = module.registry.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_user_assigned_identity.workload.principal_id
  principal_type       = "ServicePrincipal"
}

module "container_platform" {
  source = "./modules/container_platform"

  name_prefix                = local.name_prefix
  location                   = azurerm_resource_group.platform.location
  resource_group_name        = azurerm_resource_group.platform.name
  infrastructure_subnet_id   = module.networking.container_apps_subnet_id
  log_analytics_workspace_id = module.observability.log_analytics_workspace_id
  workload_identity_id       = azurerm_user_assigned_identity.workload.id
  registry_server            = module.registry.login_server
  container_image            = var.container_image
  allowed_ingress_cidrs      = var.allowed_ingress_cidrs
  tags                       = local.common_tags

  depends_on = [azurerm_role_assignment.workload_acr_pull]
}
