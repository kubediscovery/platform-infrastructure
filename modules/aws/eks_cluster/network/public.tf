resource "aws_subnet" "eks_subnet_plublic_1a" {
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = cidrsubnet(var.cidr_block, 7, 1)
  availability_zone       = "${data.aws_region.current.name}a"
  map_public_ip_on_launch = true
  tags = merge(
    local.tags,
    {
      Name                     = "${var.project_name}-pub-subnet-1a"
      "Kubernetes.io/role/elb" = "1"
    }
  )
}

resource "aws_subnet" "eks_subnet_plublic_1b" {
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = cidrsubnet(var.cidr_block, 7, 2)
  availability_zone       = "${data.aws_region.current.name}b"
  map_public_ip_on_launch = true
  tags = merge(
    local.tags,
    {
      Name                     = "${var.project_name}-pub-subnet-1b"
      "Kubernetes.io/role/elb" = "1"
    }
  )
}


resource "aws_route_table_association" "eks_rtn_assoc_1a" {
  subnet_id      = aws_subnet.eks_subnet_plublic_1a.id
  route_table_id = aws_route_table.eks_public_route_table.id
}

resource "aws_route_table_association" "eks_rtn_assoc_1b" {
  subnet_id      = aws_subnet.eks_subnet_plublic_1b.id
  route_table_id = aws_route_table.eks_public_route_table.id
}