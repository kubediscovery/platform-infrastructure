resource "aws_eks_node_group" "eks_node_group" {
  cluster_name    = var.cluster_name
  node_group_name = "${var.project_name}-nodegroup"
  node_role_arn   = aws_iam_role.eks_mng_role.arn
  subnet_ids      = var.subnet_ids
  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-nodegroup"
    }
  )

  scaling_config {
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size
  }
  capacity_type  = var.capacity_type
  instance_types = var.instance_types
  # remote_access {
  #   ec2_ssh_key               = var.ec2_ssh_key
  #   source_security_group_ids = var.source_security_group_ids
  # }
  # disk_size       = var.disk_size
  # ami_type        = var.ami_type
  # release_version = var.release_version
  version = var.mng_version

  depends_on = [
    aws_iam_role_policy_attachment.eks_mng_role_attachment_worker,
    aws_iam_role_policy_attachment.eks_mng_role_attachment_ecr,
    aws_iam_role_policy_attachment.eks_mng_role_attachment_cni
  ]
}