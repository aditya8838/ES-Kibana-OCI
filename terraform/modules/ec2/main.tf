resource "aws_instance" "jumphost" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = var.public_subnet1_id
  vpc_security_group_ids = [var.jumphost_sg_id]
  associate_public_ip_address = true

  tags = {
    Name = "jumphost"
  }

  provisioner "file" {
    source      = var.key_file_path
    destination = "/home/ubuntu/testkey.pem"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod 400 /home/ubuntu/testkey.pem"
    ]
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file(var.key_file_path)
    host        = self.public_ip
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
