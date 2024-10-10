locals {
  aws_enabled   = var.cloud_provider == "aws" ? 1 : 0
  azure_enabled = var.cloud_provider == "azure" ? 1 : 0
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