terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket = "kubediscovery"
    key    = "platform/terraform/infrastructure/terraform-cluster.tfstate"
    region = "us-east-1"
  }
}
