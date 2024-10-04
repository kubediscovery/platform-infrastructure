# output "subnet_public" {
#   value = aws_subnet.eks_public_subnet
#   description = "value of eks_public_subnet"
# }

output "list_subnet_private" {
  value       = [aws_subnet.eks_private_subnet_1a.id, aws_subnet.eks_private_subnet_1b.id]
  description = "value of eks_private_subnet"
}

output "list_subnet_public" {
  value       = [aws_subnet.eks_public_subnet_1a.id, aws_subnet.eks_public_subnet_1b.id]
  description = "value of eks_public_subnet"
}