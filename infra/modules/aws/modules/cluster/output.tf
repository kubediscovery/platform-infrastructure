output "eks_vpc_config" {
  value = aws_eks_cluster.eks_cluster
}

output "oidc" {
  value = aws_eks_cluster.eks_cluster
}

output "eks_oidc_tls_certificate" {
  value = data.tls_certificate.eks_oidc_tls_certificate
}

output "cluster_name" {
  value = aws_eks_cluster.eks_cluster.name
}

output "cluster_id" {
  value = aws_eks_cluster.eks_cluster.id
}