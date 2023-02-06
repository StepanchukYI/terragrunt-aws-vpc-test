# Subnets
output "igw_id" {
  description = "Internet Gateway ID"
  value       = aws_internet_gateway.gw.id
}