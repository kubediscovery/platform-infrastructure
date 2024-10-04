resource "aws_vpc" "eks_vpc" {
  cidr_block           = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags                 = merge({ "Name" : "${var.name_prefix}-vpc" }, var.tags)
}

# resource "aws_subnet" "eks_private_subnet" {
#   for_each = { for subnet in var.private_subnet : subnet.name => subnet }

#   vpc_id                  = aws_vpc.eks_vpc.id
#   cidr_block              = cidrsubnet(var.cidr_block, each.value.newbits, each.value.netnum)
#   availability_zone       = each.value.availability_zone
#   map_public_ip_on_launch = each.value.map_public_ip_on_launch
#   tags                    = merge({ "Name" : "${var.name_prefix}-${each.value.name}-snet" }, each.value.tags, var.tags)
# }

resource "aws_subnet" "eks_private_subnet_1a" {

  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = cidrsubnet(var.cidr_block, var.private_subnet_1a.newbits, var.private_subnet_1a.netnum)
  availability_zone       = var.private_subnet_1a.availability_zone
  map_public_ip_on_launch = var.private_subnet_1a.map_public_ip_on_launch
  tags                    = merge({ "Name" : "${var.name_prefix}-${var.private_subnet_1a.name}-snet" }, var.private_subnet_1a.tags, var.tags)
}

resource "aws_subnet" "eks_private_subnet_1b" {

  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = cidrsubnet(var.cidr_block, var.private_subnet_1b.newbits, var.private_subnet_1b.netnum)
  availability_zone       = var.private_subnet_1b.availability_zone
  map_public_ip_on_launch = var.private_subnet_1b.map_public_ip_on_launch
  tags                    = merge({ "Name" : "${var.name_prefix}-${var.private_subnet_1b.name}-snet" }, var.private_subnet_1b.tags, var.tags)
}

resource "aws_subnet" "eks_public_subnet_1a" {
  # for_each = { for subnet in var.public_subnet : subnet.name => subnet }

  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = cidrsubnet(var.cidr_block, var.public_subnet_1a.newbits, var.public_subnet_1a.netnum)
  availability_zone       = var.public_subnet_1a.availability_zone
  map_public_ip_on_launch = var.public_subnet_1a.map_public_ip_on_launch
  tags                    = merge({ "Name" : "${var.name_prefix}-${var.public_subnet_1a.name}-snet" }, var.public_subnet_1a.tags, var.tags)
}

resource "aws_subnet" "eks_public_subnet_1b" {
  # for_each = { for subnet in var.public_subnet : subnet.name => subnet }

  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = cidrsubnet(var.cidr_block, var.public_subnet_1b.newbits, var.public_subnet_1b.netnum)
  availability_zone       = var.public_subnet_1b.availability_zone
  map_public_ip_on_launch = var.public_subnet_1b.map_public_ip_on_launch
  tags                    = merge({ "Name" : "${var.name_prefix}-${var.public_subnet_1b.name}-snet" }, var.public_subnet_1b.tags, var.tags)
}

resource "aws_route_table_association" "association_1b" {
  subnet_id      = aws_subnet.eks_public_subnet_1b.id
  route_table_id = aws_route_table.public_rtb.id
}

resource "aws_route_table_association" "association_1a" {
  subnet_id      = aws_subnet.eks_public_subnet_1a.id
  route_table_id = aws_route_table.public_rtb.id
}

