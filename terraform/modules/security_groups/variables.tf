variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "elasticsearch1_private_ip" {
  description = "Private IP of Elasticsearch Node 1 (e.g., 192.168.1.10)"
  type        = string
}

variable "elasticsearch2_private_ip" {
  description = "Private IP of Elasticsearch Node 2"
  type        = string
}

variable "elasticsearch3_private_ip" {
  description = "Private IP of Elasticsearch Node 3"
  type        = string
}

variable "elasticsearch4_private_ip" {
  description = "Private IP of Elasticsearch Node 4"
  type        = string
}
