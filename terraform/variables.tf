variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "192.168.0.0/16"
}

variable "vpc_name" {
  description = "Name tag for the VPC"
  type        = string
  default     = "project-vpc"
}

variable "az1" {
  description = "First availability zone"
  type        = string
  default     = "ap-south-1a"
}

variable "az2" {
  description = "Second availability zone"
  type        = string
  default     = "ap-south-1b"
}

variable "igw_name" {
  description = "Name tag for the Internet Gateway"
  type        = string
  default     = "project-igw"
}

variable "nat_gateway_name" {
  description = "Name tag for the NAT Gateway"
  type        = string
  default     = "project-natgw"
}

variable "peering_name" {
  description = "Name tag for the peering connection"
  type        = string
  default     = "project-peering"
}

variable "alb_name" {
  description = "Name of the Application Load Balancer"
  type        = string
  default     = "project-lb"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instances"
  type        = string
  default     = "ami-0f5ee92e2d63afc18" # Ubuntu 22.04 LTS
}

variable "instance_type" {
  description = "Instance type for the EC2 instances"
  type        = string
  default     = "t2.medium"
}

variable "key_name" {
  description = "Key pair name for the EC2 instances"
  type        = string
  default     = "testkey"
}
