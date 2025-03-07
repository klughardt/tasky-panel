

# Overly permissive role for MongoDB instance
resource "aws_iam_role" "mongodb_instance" {
  name = "mongodb-instance-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

/*
resource "aws_iam_role_policy_attachment" "mongodb_admin" {
  role       = aws_iam_role.mongodb_instance.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

# EKS Cluster Role
resource "aws_iam_role" "eks_cluster" {
  name = "wiz-eks-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_cluster" {
  role       = aws_iam_role.eks_cluster.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

# CircleCI Deployment Role
resource "aws_iam_role" "circleci_deploy" {
  name = "circleci-deploy-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "circleci_deploy" {
  role       = aws_iam_role.circleci_deploy.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
*/