output "vpc_id" {
  description = "ID of the created VPC."
  value       = aws_vpc.this.id
}

output "vpc_cidr_block" {
  description = "CIDR block of the created VPC."
  value       = aws_vpc.this.cidr_block
}

output "public_subnet_ids" {
  description = "Public subnet IDs, ordered by availability zone."
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "Private subnet IDs, ordered by availability zone."
  value       = aws_subnet.private[*].id
}

output "nat_gateway_id" {
  description = "NAT gateway ID, or null when NAT is disabled."
  value       = try(aws_nat_gateway.this[0].id, null)
}
