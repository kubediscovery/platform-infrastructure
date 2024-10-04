variable "cluster_name" {
  type        = string
  description = "EKS cluster name to created MNG"
}

variable "project_name" {
  type        = string
  description = "value to be used as prefix for all resources"
  default     = "platform"
}

variable "tags" {
  type = object({
    PartOf  = string
    Owner   = string
    Support = string
  })
  description = "VPC ID"
  default = {
    PartOf  = "platform"
    Owner   = "owner"
    Support = "support"
  }
}

variable "private_subnet" {
  type        = list(string)
  description = "List of private subnets"
}