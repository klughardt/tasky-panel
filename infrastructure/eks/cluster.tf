/*

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "18.30.2"
  
  cluster_name    = "wiz-exercise-cluster"
  cluster_version = "1.25"
  vpc_id          = module.vpc.vpc_id
  subnets         = module.vpc.private_subnets
  
  node_groups = {
    primary = {
      desired_capacity = 2
      max_capacity     = 3
      min_capacity     = 1
      instance_types   = ["t3.medium"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "eks_admin" {
  role       = module.eks.cluster_iam_role_name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

*/