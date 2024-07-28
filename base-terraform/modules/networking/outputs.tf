output "vpc_id" {
  description = "The ID of the VPC created"
  value       = aws_vpc.kubernetes.id
}

output "private_subnets" {
  description   = "The IDs of the private subnets created"
  value         = aws_subnet.private[*].id
}

output "public_subnets" {
  description   = "The IDs of the private subnets created"
  value         = aws_subnet.public[*].id
}