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

variable "project_name" {
  type        = string
  description = "value to be used as prefix for all resources"
  default     = "platform2"
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}