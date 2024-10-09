locals {
  kubeconfig = templatefile("${path.module}/templates/kubeconfig.tpl", {
    cluster_arn         = module.cluster.raw.arn
    cluster_name        = module.cluster.cluster_name
    region              = data.aws_region.current.name
    kubeconfig_id       = module.cluster.cluster_name
    endpoint            = module.cluster.endpoint
    cluster_auth_base64 = module.cluster.certificate_authority[0].data
    token               = data.aws_eks_cluster_auth.this.token
  })
}
