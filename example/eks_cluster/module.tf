
locals {
  yaml_clusters = yamldecode(file("${path.module}/projects/config.yaml"))["clusters"]
  yaml_projects = { for cluster in local.yaml_clusters : cluster.name => yamldecode(file("${path.module}/projects/configs/${cluster.name}.yaml")) }
  yaml_configs  = yamldecode(file("${path.module}/projects/configs/learn.yaml"))

  cluster_endpoint = module.ascode.endpoint
  cluster_name     = module.ascode.cluster_name
  cluster_ca       = module.ascode.certificate_authority[0].data
}


module "ascode" {
  source = "../../modules/aws/eks_cluster"

  project_name = local.yaml_configs.name
  tags         = local.yaml_configs.tags
  region       = local.yaml_configs.region
}
