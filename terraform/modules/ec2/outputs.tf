output "elasticsearch1_id" {
  description = "ID of the first Elasticsearch instance"
  value       = aws_instance.elasticsearch1.id
}

output "elasticsearch2_id" {
  description = "ID of the second Elasticsearch instance"
  value       = aws_instance.elasticsearch2.id
}

output "elasticsearch3_id" {
  description = "ID of the third Elasticsearch instance"
  value       = aws_instance.elasticsearch3.id
}

output "elasticsearch4_id" {
  description = "ID of the fourth Elasticsearch instance"
  value       = aws_instance.elasticsearch4.id
}

output "kibana1_id" {
  description = "ID of the first Kibana instance"
  value       = aws_instance.kibana1.id
}

output "kibana2_id" {
  description = "ID of the second Kibana instance"
  value       = aws_instance.kibana2.id
}
