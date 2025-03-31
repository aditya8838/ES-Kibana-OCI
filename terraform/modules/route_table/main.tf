resource "aws_route_table" "public_rt" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw_id
  }

  tags = {
    Name = "public-rt"
  }
}

resource "aws_route_table_association" "public1" {
  subnet_id      = var.public_subnet1_id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public2" {
  subnet_id      = var.public_subnet2_id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table" "private_rt" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = var.nat_gateway_id
  }

  # New route for VPC peering
  route {
    cidr_block                = "10.0.0.0/16"  # Demo-VPC CIDR
    vpc_peering_connection_id = var.peering_connection_id
  }

  tags = {
    Name = "private-rt"
  }
}

resource "aws_route_table_association" "private1" {
  subnet_id      = var.private_subnet1_id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private2" {
  subnet_id      = var.private_subnet2_id
  route_table_id = aws_route_table.private_rt.id
}
