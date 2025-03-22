resource "aws_eip" "nat_eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "project_natgw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = var.public_subnet1_id
  tags = {
    Name = var.nat_gateway_name
  }
}
