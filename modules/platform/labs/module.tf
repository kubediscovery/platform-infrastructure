locals {
  aws_enabled   = var.cloud_provider == "aws" ? [] : []
  azure_enabled = var.cloud_provider == "azure"
}

output "enabled_provider" {
  value = {
    "azure" = local.azure_enabled
    "aws"   = local.aws_enabled
  }
}
resource "null_resource" "aws" {
  count = local.aws_enabled ? 1 : 0
}

resource "null_resource" "azure" {
  count = local.azure_enabled ? 1 : 0
}

module "platform" {
  source = "git::https://github.com/kubediscovery/platform-infrastructure.git//modules/aws/eks_cluster?ref=main"

  for_each     = local.aws_enabled
  project_name = var.project_name
  cidr_block   = var.cidr_block
  tags         = var.tags
  region       = resource.null_resource.azure
}
