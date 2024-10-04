resource "aws_iam_role" "eks_cluster_role" {
  name = "${var.project_name}-cluster-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = merge({ "Name" : "${var.project_name}-cluster-role" }, var.tags)
}

resource "aws_iam_role_policy_attachment" "iam_policy_attachment" {
  role      = aws_iam_role.eks_cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}
