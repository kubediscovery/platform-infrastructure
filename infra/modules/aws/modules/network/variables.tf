variable "cidr_block" {
  type        = string
  description = "Networking CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

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


variable "private_subnet_1a" {
  type = object({
    name                    = string
    availability_zone       = string
    map_public_ip_on_launch = bool
    newbits                 = number
    netnum                  = number
    tags                    = map(string)
  })
  description = "Networking subnet for the VPC"
  default = {
    availability_zone       = "us-east-1a"
    map_public_ip_on_launch = false
    newbits                 = 7
    netnum                  = 3
    name                    = "private1a"
    tags = {
      "kubernetes.io/role/internal-elb" = "1"
      "Scope"                           = "private"
    }
  }
}
variable "private_subnet_1b" {
  type = object({
    name                    = string
    availability_zone       = string
    map_public_ip_on_launch = bool
    newbits                 = number
    netnum                  = number
    tags                    = map(string)
  })
  description = "Networking subnet for the VPC"
  default = {
    availability_zone       = "us-east-1b"
    map_public_ip_on_launch = false
    newbits                 = 7
    netnum                  = 4
    name                    = "private1b"
    tags = {
      "kubernetes.io/role/internal-elb" = "1"
      "Scope"                           = "private"
    }
  }
}
variable "private_subnet" {
  type = list(object({
    name                    = string
    availability_zone       = string
    map_public_ip_on_launch = bool
    newbits                 = number
    netnum                  = number
    tags                    = map(string)
  }))
  description = "Networking subnet for the VPC"
  default = [{
    availability_zone       = "us-east-1a"
    map_public_ip_on_launch = false
    newbits                 = 7
    netnum                  = 3
    name                    = "private1a"
    tags = {
      "kubernetes.io/role/internal-elb" = "1"
      "Scope"                           = "private"
    }
    },
    {
      availability_zone       = "us-east-1b"
      map_public_ip_on_launch = false
      newbits                 = 7
      netnum                  = 4
      name                    = "private1b"
      tags = {
        "kubernetes.io/role/internal-elb" = "1"
        "Scope"                           = "private"
      }
  }]
}

variable "public_subnet_1a" {
  type = object({
    name                    = string
    availability_zone       = string
    map_public_ip_on_launch = bool
    newbits                 = number
    netnum                  = number
    tags                    = map(string)
  })
  description = "Networking subnet for the VPC"
  default = {
    availability_zone       = "us-east-1a"
    map_public_ip_on_launch = true
    newbits                 = 7
    netnum                  = 1
    name                    = "public1a"
    tags = {
      "kubernetes.io/role/elb" = "1"
      "Scope"                  = "public"
    }
  }
}


variable "public_subnet_1b" {
  type = object({
    name                    = string
    availability_zone       = string
    map_public_ip_on_launch = bool
    newbits                 = number
    netnum                  = number
    tags                    = map(string)
  })
  description = "Networking subnet for the VPC"
  default = {
    availability_zone       = "us-east-1b"
    map_public_ip_on_launch = true
    newbits                 = 7
    netnum                  = 2
    name                    = "public1b"
    tags = {
      "kubernetes.io/role/elb" = "1"
      "Scope"                  = "public"
    }
  }
}


variable "public_subnet" {
  type = list(object({
    name                    = string
    availability_zone       = string
    map_public_ip_on_launch = bool
    newbits                 = number
    netnum                  = number
    tags                    = map(string)
  }))
  description = "Networking subnet for the VPC"
  default = [{
    availability_zone       = "us-east-1a"
    map_public_ip_on_launch = true
    newbits                 = 7
    netnum                  = 1
    name                    = "public1a"
    tags = {
      "kubernetes.io/role/elb" = "1"
      "Scope"                  = "public"
    }
    },
    {
      availability_zone       = "us-east-1b"
      map_public_ip_on_launch = true
      newbits                 = 7
      netnum                  = 2
      name                    = "public1b"
      tags = {
        "kubernetes.io/role/elb" = "1"
        "Scope"                  = "public"
      }
  }]
}
