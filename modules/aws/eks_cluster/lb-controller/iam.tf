locals {
  oidc = split("/", var.oidc_provider_url)
}

resource "aws_iam_role" "eks_lb_controller_role" {
  name = "${var.project_name}-eks-lb-controller-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Federated = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/${data.aws_region.current.name}.amazonaws.com/id/${local.oidc[length(local.oidc) - 1]}"
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            "oidc.eks.${data.aws_region.current.name}.amazonaws.com/id/${local.oidc[length(local.oidc) - 1]}:aud" : "sts.amazonaws.com",
            "oidc.eks.${data.aws_region.current.name}.amazonaws.com/id/${local.oidc[length(local.oidc) - 1]}:sub" : "system:serviceaccount:kube-system:aws-load-balancer-controller"
          }
        }
      }
    ]
  })

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-eks-lb-controller-role"
    }
  )
}

resource "aws_iam_role_policy_attachment" "eks_lb-controller_policy_attachment" {
  role       = aws_iam_role.eks_lb_controller_role.name
  policy_arn = aws_iam_policy.eks_controller_policy.arn
}