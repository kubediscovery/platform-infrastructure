terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.48.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.32.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.8.0"
    }
  }
}

provider "aws" {
  region = var.region
}

provider "kubernetes" {
  host                   = module.cluster.endpoint
  cluster_ca_certificate = base64decode(module.cluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.this.token
  # host                   = module.cluster.endpoint
  # cluster_ca_certificate = base64decode(module.cluster.certificate_authority[0].data)

  # exec {
  #   api_version = "client.authentication.k8s.io/v1beta1"
  #   command     = "aws"
  #   args        = ["eks", "get-token", "--cluster-name", module.cluster.cluster_name]
  # }
}


provider "helm" {
  debug = true
  kubernetes {
    host                   = module.cluster.endpoint
    cluster_ca_certificate = base64decode(module.cluster.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.this.token
  }
  # kubernetes {
  #   host                   = module.cluster.endpoint
  #   cluster_ca_certificate = base64decode(module.cluster.certificate_authority[0].data)

  #   exec {
  #     api_version = "client.authentication.k8s.io/v1beta1"
  #     command     = "aws"
  #     args        = ["eks", "get-token", "--cluster-name", module.cluster.cluster_name]
  #   }
  # }
}
