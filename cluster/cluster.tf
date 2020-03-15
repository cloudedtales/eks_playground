resource "aws_iam_role" "demo-cluster" {
  name = "terraform-eks-demo-cluster-role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "demo-cluster-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.demo-cluster.name
}

resource "aws_iam_role_policy_attachment" "demo-cluster-AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.demo-cluster.name
}

resource "aws_eks_cluster" "demo" {
  name = var.cluster-name
  role_arn = aws_iam_role.demo-cluster.arn
  version = var.kubernetes_version

  vpc_config {
    subnet_ids = aws_subnet.eks_demo.*.id
  }

  depends_on = [
    aws_iam_role_policy_attachment.demo-cluster-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.demo-cluster-AmazonEKSServicePolicy,
    aws_cloudwatch_log_group.log
  ]
  enabled_cluster_log_types = ["api","audit"]
}

resource "aws_cloudwatch_log_group" "log"{
  name = "/aws/eks/${var.cluster-name}/cluster"
  retention_in_days = var.log_retention_in_days
}


output "cluster-name" {
  value = aws_eks_cluster.demo.name
}

output "cluster" {
  value = aws_eks_cluster.demo.endpoint
}
