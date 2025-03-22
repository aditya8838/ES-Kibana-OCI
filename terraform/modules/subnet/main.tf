resource "aws_subnet" "public_subnet1" {
  vpc_id            = var.vpc_id
  cidr_block        = cidrsubnet(var.vpc_cidr, 4, 0)
  availability_zone = var.az1
  tags = {
    Name = "public-subnet1"
  }
}

resource "aws_subnet" "private_subnet1" {
  vpc_id            = var.vpc_id
  cidr_block        = cidrsubnet(var.vpc_cidr, 4, 1)
  availability_zone = var.az1
  tags = {
    Name = "private-subnet1"
  }
}

resource "aws_subnet" "public_subnet2" {
  vpc_id            = var.vpc_id
  cidr_block        = cidrsubnet(var.vpc_cidr, 4, 2)
  availability_zone = var.az2
  tags = {
    Name = "public-subnet2"
  }
}

resource "aws_subnet" "private_subnet2" {
  vpc_id            = var.vpc_id
  cidr_block        = cidrsubnet(var.vpc_cidr, 4, 3)
  availability_zone = var.az2
  tags = {
    Name = "private-subnet2"
  }
}
