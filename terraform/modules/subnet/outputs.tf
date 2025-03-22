output "public_subnet1_id" {
  description = "ID of the first public subnet"
  value       = aws_subnet.public_subnet1.id
}

output "public_subnet2_id" {
  description = "ID of the second public subnet"
  value       = aws_subnet.public_subnet2.id
}

output "private_subnet1_id" {
  description = "ID of the first private subnet"
  value       = aws_subnet.private_subnet1.id
}

output "private_subnet2_id" {
  description = "ID of the second private subnet"
  value       = aws_subnet.private_subnet2.id
}
