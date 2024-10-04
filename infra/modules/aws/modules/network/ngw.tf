resource "aws_eip" "eks_ngw_eip1a" {
  vpc  = true
  tags = merge({ "Name" : "${var.name_prefix}-eip1a" }, var.tags)
}
resource "aws_eip" "eks_ngw_eip1b" {
  vpc  = true
  tags = merge({ "Name" : "${var.name_prefix}-eip1b" }, var.tags)
}

resource "aws_nat_gateway" "eks_ngw_1a" {

  allocation_id = aws_eip.eks_ngw_eip1a.id
  subnet_id     = aws_subnet.eks_private_subnet_1a.id
  tags          = merge({ "Name" : "${var.name_prefix}-eip1a" }, var.tags)

}

resource "aws_nat_gateway" "eks_ngw_1b" {

  allocation_id = aws_eip.eks_ngw_eip1b.id
  subnet_id     = aws_subnet.eks_private_subnet_1b.id
  tags          = merge({ "Name" : "${var.name_prefix}-eip1b" }, var.tags)
}


resource "aws_route_table" "private_rtb_1a" {
  vpc_id = aws_vpc.eks_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.eks_ngw_1a.id
  }

  tags = merge({ "Name" : "${var.name_prefix}-priv-rtb1a" }, var.tags)
}


resource "aws_route_table" "private_rtb_1b" {
  vpc_id = aws_vpc.eks_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.eks_ngw_1b.id
  }

  tags = merge({ "Name" : "${var.name_prefix}-priv-rtb1b" }, var.tags)
}


resource "aws_route_table_association" "private1a" {

  subnet_id      = aws_subnet.eks_private_subnet_1a.id
  route_table_id = aws_route_table.private_rtb_1a.id
}

resource "aws_route_table_association" "private1b" {

  subnet_id      = aws_subnet.eks_private_subnet_1b.id
  route_table_id = aws_route_table.private_rtb_1b.id
}

# resource "aws_route_table_association" "private1b" {
#   for_each = { for subnet in var.private_subnet : subnet.name => aws_subnet.eks_private_subnet[subnet.name] if subnet.availability_zone == "us-east-1b" }

#   subnet_id      = each.value.id
#   route_table_id = aws_route_table.private_rtb-1b.id
# }