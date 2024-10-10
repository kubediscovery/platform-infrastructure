# module "vpc" {
#   source  = "terraform-aws-modules/vpc/aws"
#   version = "5.0.0"

#   name = "${var.project_name}-vpc"
#   cidr = var.cidr_block


#   azs = ["us-east-1a", "us-east-1b"]
#   #private_subnets     = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k)]
#   #public_subnets      = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 4)]
#   private_subnets = [cidrsubnet(var.cidr_block, 7, 1), cidrsubnet(var.cidr_block, 7, 2)]
#   public_subnets  = [cidrsubnet(var.cidr_block, 7, 3), cidrsubnet(var.cidr_block, 7, 4)]

#   enable_nat_gateway     = true
#   single_nat_gateway     = true
#   one_nat_gateway_per_az = false
#   enable_dns_hostnames   = true
#   enable_dns_support     = true

#   public_subnet_tags = {
#     "kubernetes.io/role/elb" = 1
#   }

#   private_subnet_tags = {
#     "kubernetes.io/role/internal-elb" = 1
#   }


#   tags = var.tags
# }
# provider "aws" {
#   region = local.region
# }

data "aws_availability_zones" "available" {}

# locals {
#   name   = "ex-eks-mng"
#   region = "eu-west-1"

#   vpc_cidr = "10.0.0.0/16"
#   azs      = slice(data.aws_availability_zones.available.names, 0, 3)

#   tags = {
#     Example    = local.name
#     GithubRepo = "terraform-aws-eks"
#     GithubOrg  = "terraform-aws-modules"
#   }
# }

################################################################################
# VPC
################################################################################

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "${var.project_name}-vpc"
  cidr = var.cidr_block

  azs             = ["us-east-1a", "us-east-1b"]
  private_subnets = [cidrsubnet(var.cidr_block, 7, 1), cidrsubnet(var.cidr_block, 7, 2)]
  public_subnets  = [cidrsubnet(var.cidr_block, 7, 3), cidrsubnet(var.cidr_block, 7, 4)]
  intra_subnets   = [cidrsubnet(var.cidr_block, 7, 5), cidrsubnet(var.cidr_block, 7, 6)]

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true
  enable_dns_support   = true


  public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
  }

  tags = var.tags
}