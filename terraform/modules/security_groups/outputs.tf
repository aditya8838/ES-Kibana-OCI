output "lb_sg_id" {
  description = "ID of the load balancer security group"
  value       = aws_security_group.lb_sg.id
}

output "elastic_sg_id" {
  description = "ID of the Elasticsearch security group"
  value       = aws_security_group.elastic_sg.id
}

output "k_sg_id" {
  description = "ID of the Kibana security group"
  value       = aws_security_group.k_sg.id
}

output "jumphost_sg_id" {
  description = "ID of the jumphost security group"
  value       = aws_security_group.jumphost_sg.id
}
