# VPC Configuration
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

# Availability Zones
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

# Internet Gateway
variable "igw_name" {
  description = "Name tag for the Internet Gateway"
  type        = string
  default     = "project-igw"
}

# NAT Gateway
variable "nat_gateway_name" {
  description = "Name tag for the NAT Gateway"
  type        = string
  default     = "project-natgw"
}

# VPC Peering
variable "peering_name" {
  description = "Name tag for the peering connection"
  type        = string
  default     = "project-peering"
}

variable "demo_vpc_id" {
  description = "ID of the Demo-VPC for peering"
  type        = string
  default     = "vpc-0996ede71c3cf9ec2"
}

# Load Balancer
variable "alb_name" {
  description = "Name of the Application Load Balancer"
  type        = string
  default     = "project-lb"
}

# EC2 Instances
variable "ami_id" {
  description = "AMI ID for the EC2 instances"
  type        = string
  default     = "ami-0f5ee92e2d63afc18"
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

variable "key_file_path" {
  description = "Path to the private key file for EC2 instances"
  type        = string
  default     = "/var/lib/jenkins/workspace/testkey.pem"
}
