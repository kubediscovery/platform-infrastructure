# output "eks_vpc_config" {
#   value = module.cluster.eks_vpc_config
# }

# output "oidc_provider" {
#   value = module.cluster.oidc_provider
# }

# output "oidc" {
#   value = module.cluster.oidc
# }

# output "certificate_authority" {
#   value = module.cluster.certificate_authority
# }

# output "endpoint" {
#   value = module.cluster.endpoint
# }

# output "cluster_name" {
#   value = module.cluster.cluster_name
# }

# output "lb_oidc" {
#   value = module.lb_controller.lb_oidc
# }

# output "cluster" {
#   value = {
#     # "oidc"                   = module.lb_controller.lb_oidc
#     "endpoint"                   = module.cluster.endpoint
#     "cluster_name"               = module.cluster.cluster_name
#     "cluster_id"                 = module.cluster.raw.arn
#     "certificate_authority"      = module.cluster.certificate_authority
#     "cluster_ca_certificate"     = module.cluster.certificate_authority[0].data
#     "cluster_ca_certificate_b64" = base64encode(module.cluster.certificate_authority[0].data)
#   }
# }

# output "kubeconfig" {
#   value = local.kubeconfig
# }

