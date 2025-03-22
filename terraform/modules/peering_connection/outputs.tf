output "project_peering_id" {
  description = "ID of the VPC peering connection"
  value       = aws_vpc_peering_connection.project_peering.id
}
