
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

variable "public_subnet" {
  type        = list(string)
  description = "List of public subnets"
}

# variable "private_subnet" {
#  type = list(string)
#   description = "List of private subnets"
# }