# Lookup Demo-VPC's public route table by tag
data "aws_route_table" "demo_pub_rt" {
  vpc_id = var.demo_vpc_id
  filter {
    name   = "tag:Name"
    values = ["Pub-RT"]  # Must match the tag in Demo-VPC
  }
}

# Your project VPC's public route table
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

# Your project VPC's private route table
resource "aws_route_table" "private_rt" {
  vpc_id = var.vpc_id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = var.nat_gateway_id
  }
  route {
    cidr_block                = "10.0.0.0/16"  # Route to Demo-VPC
    vpc_peering_connection_id = var.peering_connection_id
  }
  tags = {
    Name = "private-rt"
  }
}

# Add reciprocal route to Demo-VPC's public route table
resource "aws_route" "demo_vpc_route" {
  route_table_id            = data.aws_route_table.demo_pub_rt.id
  destination_cidr_block    = "192.168.0.0/16"  # Your VPC's CIDR
  vpc_peering_connection_id = var.peering_connection_id
}

# Route table associations (unchanged)
resource "aws_route_table_association" "public1" {
  subnet_id      = var.public_subnet1_id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public2" {
  subnet_id      = var.public_subnet2_id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "private1" {
  subnet_id      = var.private_subnet1_id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private2" {
  subnet_id      = var.private_subnet2_id
  route_table_id = aws_route_table.private_rt.id
}
