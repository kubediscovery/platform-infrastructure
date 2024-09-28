variable "name_prefix" {
  type        = string
  description = "value to be used as prefix for all resources"
  default     = "platform"
}

variable "vpc" {
  type = object({

    cidr_block = string
  })
  description = "VPC ID"

  default = {
    cidr_block = "10.0.0.0/16"
  }
}

variable "nat_gateway" {
  type        = string
  description = "NAT Gateway ID"
  default     = ""
}

variable "internet_gateway" {
  type        = string
  description = "Internet Gateway ID"
  default     = ""
}

variable "tags" {
  type = object({
    partOf = string
  })
  description = "VPC ID"
  default = {
    partOf = "platform"
  }
}