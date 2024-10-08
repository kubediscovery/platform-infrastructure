variable "tags" {
  type        = map(string)
  description = "Tags to be added to the AWS resources"
  default = {
    Environment = "dev"
    PartOf      = "learn-aws"
  }
}

variable "project_name" {
  type    = string
  default = "Name of the project and prefix for resources"
}

variable "cidr_block" {
  type        = string
  description = "Networking CIDR block to be used for the VPC"
  default     = "10.0.0.0/16"
}

variable "region" {
  type        = string
  description = "AWS region to create the resources"
}