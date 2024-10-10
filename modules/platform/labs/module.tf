module "platform" {
  source = "git::https://github.com/kubediscovery/platform-infrastructure.git//modules/aws/eks_cluster?ref=develop"

  project_name = var.project_name
  cidr_block   = var.cidr_block
  tags         = var.tags
  region       = var.region
}
