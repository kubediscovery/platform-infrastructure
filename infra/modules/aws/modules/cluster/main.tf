resource "aws_eks_cluster" "eks_cluster" {
  name     = "${var.project_name}-eks"
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids              = var.public_subnet
    endpoint_private_access = true
    endpoint_public_access  = true
  }

  depends_on = [
    aws_iam_role_policy_attachment.iam_policy_attachment
  ]

version = "1.30"
  tags = merge({ "Name" : "${var.project_name}-eks" }, var.tags)
}


resource "aws_security_group_rule" "eks_cluster_sg_rule" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_eks_cluster.eks_cluster.vpc_config[0].cluster_security_group_id
}


data "tls_certificate" "eks_oidc_tls_certificate" {
  url = aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "eks_oidc" {
  url = data.tls_certificate.eks_oidc_tls_certificate.url

  client_id_list = [
    "sts.amazonaws.com",
  ]

  thumbprint_list = data.tls_certificate.eks_oidc_tls_certificate.certificates[*].sha1_fingerprint

  tags = merge({ "Name" : "${var.project_name}-oidc" }, var.tags)
}