variable "alb_name" {
  description = "Name of the Application Load Balancer"
  type        = string
}

variable "lb_sg_id" {
  description = "ID of the load balancer security group"
  type        = string
}

variable "public_subnet1_id" {
  description = "ID of the first public subnet"
  type        = string
}

variable "public_subnet2_id" {
  description = "ID of the second public subnet"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "elasticsearch1_id" {
  description = "ID of the first Elasticsearch instance"
  type        = string
}

variable "elasticsearch2_id" {
  description = "ID of the second Elasticsearch instance"
  type        = string
}

variable "elasticsearch3_id" {
  description = "ID of the third Elasticsearch instance"
  type        = string
}

variable "elasticsearch4_id" {
  description = "ID of the fourth Elasticsearch instance"
  type        = string
}

variable "kibana1_id" {
  description = "ID of the first Kibana instance"
  type        = string
}

variable "kibana2_id" {
  description = "ID of the second Kibana instance"
  type        = string
}
