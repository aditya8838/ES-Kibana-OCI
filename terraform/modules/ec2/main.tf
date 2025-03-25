resource "aws_instance" "jumphost" {
  ami                    = var.jumphost_ami_id
  instance_type          = "t2.micro"
  subnet_id              = var.public_subnet1_id
  key_name               = var.key_name
  vpc_security_group_ids = [var.jumphost_sg_id]
  tags = {
    Name = "jumphost"
  }
}

resource "aws_instance" "elasticsearch1" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.private_subnet1_id
  key_name      = var.key_name
  vpc_security_group_ids = [var.elastic_sg_id]
  tags = {
    Name = "elasticsearch1"
  }
}

resource "aws_instance" "elasticsearch2" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.private_subnet1_id
  key_name      = var.key_name
  vpc_security_group_ids = [var.elastic_sg_id]
  tags = {
    Name = "elasticsearch2"
  }
}

resource "aws_instance" "kibana1" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.private_subnet1_id
  key_name      = var.key_name
  vpc_security_group_ids = [var.k_sg_id]
  tags = {
    Name = "kibana1"
  }
}

resource "aws_instance" "elasticsearch3" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.private_subnet2_id
  key_name      = var.key_name
  vpc_security_group_ids = [var.elastic_sg_id]
  tags = {
    Name = "elasticsearch3"
  }
}

resource "aws_instance" "elasticsearch4" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.private_subnet2_id
  key_name      = var.key_name
  vpc_security_group_ids = [var.elastic_sg_id]
  tags = {
    Name = "elasticsearch4"
  }
}

resource "aws_instance" "kibana2" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.private_subnet2_id
  key_name      = var.key_name
  vpc_security_group_ids = [var.k_sg_id]
  tags = {
    Name = "kibana2"
  }
}
