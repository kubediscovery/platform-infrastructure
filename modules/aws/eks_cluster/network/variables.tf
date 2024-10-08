variable "tags" {
  type = map(string)
  default = {
    Environment = "dev"
  }
}

variable "project_name" {
  type = string
}

variable "cidr_block" {
  type        = string
  description = "Networking CIDR block to be used for the VPC"
  default     = "10.0.0.0/16"
}