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
  description = "EKS cluster name to create MNG"
}

variable "subnet_ids" {
  type        = list(string)
  description = "EKS cluster name to create MNG"
}

variable "capacity_type" {
  type        = string
  description = "EKS cluster name to create MNG"
  default     = "SPOT"
}

variable "instance_types" {
  type        = list(string)
  description = "EKS cluster name to create MNG"
  default     = ["t3.medium"]
}

variable "desired_size" {
  type        = number
  description = "EKS cluster name to create MNG"
  default     = 1

}

variable "max_size" {
  type        = number
  description = "value of max size"
  default     = 1
}


variable "min_size" {
  type        = number
  description = "value of min size"
  default     = 1
}

variable "mng_version" {
  type        = string
  description = "value of version"
  default     = "1.28"
} 