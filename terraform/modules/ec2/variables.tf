variable "ami_id" {
  description = "AMI ID for the EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "Instance type for the EC2 instances"
  type        = string
}

variable "jumphost_sg_id" {
  description = "ID of the jumphost security group"
  type        = string
}

variable "public_subnet1_id" {
  description = "ID of the first private subnet"
  type        = string
}

variable "private_subnet1_id" {
  description = "ID of the first private subnet"
  type        = string
}

variable "private_subnet2_id" {
  description = "ID of the second private subnet"
  type        = string
}

variable "elastic_sg_id" {
  description = "ID of the Elasticsearch security group"
  type        = string
}

variable "k_sg_id" {
  description = "ID of the Kibana security group"
  type        = string
}

variable "key_name" {
  default = "testkey"
}
variable "key_file_path" {
  default = "/var/lib/jenkins/workspace/testkey.pem"
}
