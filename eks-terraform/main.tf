provider "aws" {
  region = "us-east-1"
}

# ----------------------------
# Existing IAM Role (LabRole)
# ----------------------------
data "aws_iam_role" "master" {
  name = "LabRole"
}

data "aws_iam_role" "worker" {
  name = "LabRole"
}

# ----------------------------
# VPC + Subnets (dynamic lookup)
# ----------------------------
data "aws_vpc" "main" {
  tags = {
    Name = "Lab-VPC"
  }
}

# Get ALL subnets in the Lab-VPC (no hardcoded subnet names)
data "aws_subnets" "selected" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.main.id]
  }
}

# Use the default SG in the VPC (always exists)
data "aws_security_group" "selected" {
  vpc_id = data.aws_vpc.main.id
  name   = "default"
}

# ----------------------------
# EKS Cluster
# ----------------------------
resource "aws_eks_cluster" "eks" {
  name     = "MelCluster"
  role_arn = data.aws_iam_role.master.arn

  vpc_config {
    subnet_ids         = data.aws_subnets.selected.ids
    security_group_ids = [data.aws_security_group.selected.id]
  }

  tags = {
    Name        = "MelCluster"
    Environment = "dev"
    Terraform   = "true"
  }
}

# ----------------------------
# EKS Node Group
# ----------------------------
resource "aws_eks_node_group" "node-grp" {
  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = var.node_group_name
  node_role_arn   = data.aws_iam_role.worker.arn

  subnet_ids    = data.aws_subnets.selected.ids
  capacity_type = "ON_DEMAND"
  disk_size     = 20

  # Learner Lab friendly (t3.medium is more available than t2.large)
  instance_types = ["t3.medium"]

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  tags = {
    Name = "lab-eks-node-group"
  }
}

# ----------------------------
# (Optional) OIDC thumbprint (you can keep it if you’ll use IRSA later)
# ----------------------------
data "aws_eks_cluster" "eks_oidc" {
  name = aws_eks_cluster.eks.name
}

data "tls_certificate" "oidc_thumbprint" {
  url = data.aws_eks_cluster.eks_oidc.identity[0].oidc[0].issuer
}
