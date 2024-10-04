resource "aws_eks_node_group" "eks_mng" {
  cluster_name    = var.cluster_name
  node_group_name = "${var.project_name}-mng"
  node_role_arn   = aws_iam_role.eks_mng_role.arn
  subnet_ids      = var.private_subnet

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 0
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.iam_mng_attachment_worker,
    aws_iam_role_policy_attachment.iam_mng_attachment_cni,
    aws_iam_role_policy_attachment.iam_mng_attachment_ecr,
  ]

  instance_types = ["t3.medium"]
  version = "1.30"
  capacity_type = "SPOT"
  tags = var.tags
}