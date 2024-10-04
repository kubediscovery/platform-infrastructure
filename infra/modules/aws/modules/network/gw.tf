resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.eks_vpc.id

  tags = merge({ "Name" : "${var.name_prefix}-igw" }, var.tags)
}

resource "aws_route_table" "public_rtb" {
  vpc_id = aws_vpc.eks_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge({ "Name" : "${var.name_prefix}-pub-rtb" }, var.tags)
}

