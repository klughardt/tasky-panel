module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "${var.project_name}-cluster"
  cluster_version = "1.31"

  cluster_enabled_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
  
  cloudwatch_log_group_retention_in_days = var.log_retention_days
  cloudwatch_log_group_kms_key_id       = null

  cluster_endpoint_public_access       = true
  cluster_endpoint_private_access      = false
  cluster_endpoint_public_access_cidrs = ["0.0.0.0/0"]

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  eks_managed_node_groups = {
    main = {
      desired_size   = 2
      min_size       = 1
      max_size       = 3
      instance_types = ["t3.medium"]
    }
  }

  enable_cluster_creator_admin_permissions = true

  access_entries = {
    root = {
      kubernetes_groups = []
      principal_arn     = "arn:aws:iam::992382393031:role/aws-reserved/sso.amazonaws.com/AWSReservedSSO_PowerUserAccess_619f3acab58b346e"

      policy_associations = {
        example = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
          access_scope = {
            type = "cluster"
          }
        }
      }
    }
  }

  tags = {
    Project = var.project_name
  }
}

resource "kubernetes_namespace" "project_namespace" {
  metadata {
    name = var.project_name
  }
}

resource "kubernetes_service_account" "web_app_sa" {
  metadata {
    name      = "web-app-sa"
    namespace = kubernetes_namespace.project_namespace.metadata[0].name
  }
}

resource "kubernetes_cluster_role_binding" "web_app_cluster_admin" {
  metadata {
    name = "web-app-cluster-admin-binding"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }

  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.web_app_sa.metadata[0].name
    namespace = kubernetes_namespace.project_namespace.metadata[0].name
  }
}