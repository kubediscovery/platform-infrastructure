locals {
  provider = var.cloud_provider == "aws" ? 1 : 0
}

module "platform" {
  source = "git::https://github.com/kubediscovery/platform-infrastructure.git//modules/aws/eks_cluster?ref=main"
  # count  = local.provider

  project_name = var.project_name
  cidr_block   = var.cidr_block
  tags         = var.tags
  region       = var.region
}
