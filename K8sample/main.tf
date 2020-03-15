provider "kubernetes" {
  host                   = data.aws_eks_cluster.demo.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.demo.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.demo.token
  load_config_file       = false
}

provider "aws" {
  region = "eu-central-1"
}

data "aws_eks_cluster" "demo" {
  name = var.cluster_name
}

data "aws_eks_cluster_auth" "demo"{
  name = var.cluster_name
}