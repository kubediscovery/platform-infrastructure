module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

  name = "${var.project_name}-vpc"
  cidr = var.cidr_block


  azs = ["us-east-1a", "us-east-1b"]
  #private_subnets     = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k)]
  #public_subnets      = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 4)]
  private_subnets = [cidrsubnet(var.cidr_block, 7, 1), cidrsubnet(var.cidr_block, 7, 2)]
  public_subnets  = [cidrsubnet(var.cidr_block, 7, 3), cidrsubnet(var.cidr_block, 7, 4)]

  enable_nat_gateway = true

  public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
  }

  tags = var.tags
}