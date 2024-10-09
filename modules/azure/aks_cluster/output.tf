output "managed" {
  value       = local.managed_by
  description = "Manage resources"
}

output "labels" {
  value       = local.labels
  description = "Labels to filter resources"
}

output "project_name" {
  value       = local.name
  description = "Project name"
}

output "environment" {
  value       = local.name
  description = "Environment"
}

output "resource_group" {
  value       = module.resource_group.raw
  description = "Resource Group Backstage entity"
}

output "identity" {
  value       = module.identity.raw
  description = "Resource Group Backstage entity"
}

output "private_dns" {
  value       = module.private_dns.raw
  description = "Resource Group Backstage entity"
}

output "log_analytics" {
  value       = module.log_analytics.raw
  description = "Resource Group Backstage entity"
  sensitive   = true
}

output "kube_config_raw" {
  value     = local.kube.kube_config_raw
  sensitive = true
}

output "kubeconfig" {
  value       = yamlencode(local.kube.kube_config[0])
  description = "Kube config"
  sensitive   = true
}

output "cluster" {
  value = {
    "endpoint"               = local.kube.kube_config[0].host
    "cluster_name"           = module.aks[0].name
    "certificate_authority"  = local.kube.kube_config[0]
    "cluster_ca_certificate" = local.kube.kube_config[0].cluster_ca_certificate
  }
}

output "endpoint" {
  value = local.kube.kube_config[0].host
}

output "cluster_name" {
  value = module.aks[0].name
}
