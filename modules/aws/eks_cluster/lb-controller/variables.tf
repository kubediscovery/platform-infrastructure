variable "tags" {
  type        = map(string)
  description = "Tags to be added to the AWS resources"
  default = {
    Environment = "dev"
    PartOf      = "learn-aws"
  }
}

variable "project_name" {
  type        = string
  description = "Name of the project and prefix for resources"
}

variable "cluster_name" {
  type        = string
  description = "AWS region to deploy the resources"
}

variable "oidc_provider_url" {
  type        = string
  description = "HTTPS URL from OIDC provider of the EKS cluster"
}
