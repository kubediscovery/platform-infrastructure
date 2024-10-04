
# Filter out local zones, which are not currently supported 
# with managed node groups

data "aws_availability_zones" "available" {
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

locals {
  cluster_name = "${var.project_name}-cluster-eks"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.8.1"

  name = "${var.project_name}-vpc"

  cidr = "10.0.0.0/16"
  azs  = slice(data.aws_availability_zones.available.names, 0, 3)

  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
    "kubernetes.io/role/external-elb" = 1
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.8.5"

  cluster_name    = local.cluster_name
  cluster_version = "1.31"

  cluster_endpoint_public_access           = true
  cluster_endpoint_public_access_cidrs           = ["0.0.0.0/0"]
  enable_cluster_creator_admin_permissions = true

  cluster_addons = {
    aws-ebs-csi-driver = {
      service_account_role_arn = module.irsa-ebs-csi.iam_role_arn
    }
  }

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  eks_managed_node_group_defaults = {
    ami_type = "AL2_x86_64"

  }

  eks_managed_node_groups = {
    one = {
      name = "node-group-1"

      instance_types = ["t3.medium"]
      capacity_type  = "SPOT"

      min_size     = 1
      max_size     = 2
      desired_size = 1
    }
  }
}

data "aws_iam_policy" "ebs_csi_policy" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
}

module "irsa-ebs-csi" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version = "5.39.0"

  create_role                   = true
  role_name                     = "AmazonEKSTFEBSCSIRole-${module.eks.cluster_name}"
  provider_url                  = module.eks.oidc_provider
  role_policy_arns              = [data.aws_iam_policy.ebs_csi_policy.arn]
  oidc_fully_qualified_subjects = ["system:serviceaccount:kube-system:ebs-csi-controller-sa"]
}

# module "argocd" {
#   source     = "./modules/argoproj/argocd"
#   count      = var.enabled_argocd.enabled == true ? 1 : 0
#   name       = var.enabled_argocd.name
#   repository = var.enabled_argocd.repository
#   chart      = var.enabled_argocd.chart
#   namespace        = var.enabled_argocd.namespace
#   installCRDs      = var.enabled_argocd.installCRDs
#   create_namespace = var.enabled_argocd.create_namespace
#   labels           = var.tags

#   depends_on    = [module.eks]

# }

# variable "enabled_argocd" {
#   type = object({
#     name             = optional(string)
#     repository       = optional(string)
#     chart            = optional(string)
#     version          = optional(string)
#     namespace        = optional(string)
#     installCRDs      = optional(bool)
#     enabled          = bool
#     create_namespace = optional(bool)

#   })
#   default = {
#     name             = "argocd"
#     enabled          = true
#     chart            = "argo-cd"
#     create_namespace = true
#   }
#   description = "ArgoCD"
# }


# data "aws_eks_cluster_auth" "this" {
#   name = module.eks.cluster_name
# }



# module "argocd_cluster" {
#   source = "./modules/argoproj/argocd_cluster"
#   cluster_address =  data.azurerm_kubernetes_cluster.this.kube_config[0].host
#   cluster_name          = data.azurerm_kubernetes_cluster.this.name
#   cluster_ca_certificate = data.azurerm_kubernetes_cluster.this.kube_config[0].cluster_ca_certificate
#   cluster_token         = data.azurerm_kubernetes_cluster.this.kube_config[0].password
#   argocd_password = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJhcmdvY2QiLCJzdWIiOiJ0b21lbGluOmFwaUtleSIsIm5iZiI6MTcyNzgwMDI4MCwiaWF0IjoxNzI3ODAwMjgwLCJqdGkiOiJjMTk5ZWRlOC0wMDc3LTRhMjAtODc3NC1jNTVhYmUwMmZmNjUifQ.yj1uJb1VIRZq08r7QUP8dHkSX-TKwrA0P2LAHb-U6aY"
# }
