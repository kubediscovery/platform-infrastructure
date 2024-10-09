//
locals {
  managed_by     = { "managed_by" : "terraform" }
  labels         = var.tags
  name           = var.project_name
  environment    = "development"
  private_domain = var.private_domain == "" ? "private.${local.name}.com" : var.private_domain

  kube = module.aks[0].raw
}

module "resource_group" {
  source   = "./modules/rsg"
  tags     = local.labels
  name     = local.name
  location = var.region
}

module "identity" {
  source         = "./modules/idm"
  tags           = local.labels
  name           = local.name
  location       = var.region
  resource_group = module.resource_group.name
}

module "private_dns" {
  source         = "./modules/private_dns"
  tags           = local.labels
  name           = local.private_domain
  resource_group = module.resource_group.name
}

module "log_analytics" {
  source         = "./modules/law"
  tags           = local.labels
  name           = local.name
  resource_group = module.resource_group.name
  identity = {
    type         = "UserAssigned"
    identity_ids = [module.identity.id]
  }
  sku               = var.law_sku
  retention_in_days = var.retention_in_days
}

module "aks" {
  source = "./modules/aks"
  count  = 1
  name   = local.name
  tags   = local.labels

  identity = {
    type         = "UserAssigned"
    identity_ids = [module.identity.id]
  }

  resource_group = module.resource_group.name

  default_node_pool = {
    name                   = var.default_node_pool.name
    node_count             = var.default_node_pool.node_count
    enable_host_encryption = var.default_node_pool.enable_host_encryption
    os_disk_size_gb        = var.default_node_pool.os_disk_size_gb
    os_disk_type           = var.default_node_pool.os_disk_type
    os_sku                 = var.default_node_pool.os_sku
    pod_subnet_id          = var.default_node_pool.pod_subnet_id
    ultra_ssd_enabled      = var.default_node_pool.ultra_ssd_enabled
    vm_size                = var.default_node_pool.vm_size
    zones                  = var.default_node_pool.zones
  }

  node_pool = var.node_pool

  oms_agent = {
    log_analytics_workspace_id = module.log_analytics.id
  }

  scale_down_mode     = var.scale_down_mode
  dns_prefix          = var.dns_prefix
  ultra_ssd_enabled   = var.ultra_ssd_enabled
  enable_auto_scaling = var.enable_auto_scaling
  network_profile     = var.network_profile
}
