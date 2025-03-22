output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet1_id" {
  description = "ID of the first public subnet"
  value       = module.subnet.public_subnet1_id
}

output "public_subnet2_id" {
  description = "ID of the second public subnet"
  value       = module.subnet.public_subnet2_id
}

output "private_subnet1_id" {
  description = "ID of the first private subnet"
  value       = module.subnet.private_subnet1_id
}

output "private_subnet2_id" {
  description = "ID of the second private subnet"
  value       = module.subnet.private_subnet2_id
}

output "igw_id" {
  description = "ID of the Internet Gateway"
  value       = module.internet_gateway.project_igw_id
}

output "nat_gateway_id" {
  description = "ID of the NAT Gateway"
  value       = module.nat_gateway.project_natgw_id
}

output "peering_connection_id" {
  description = "ID of the peering connection"
  value       = module.peering_connection.project_peering_id
}

output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = module.alb.alb_dns_name
}
