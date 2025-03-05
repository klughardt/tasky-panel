output "eks_cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "mongodb_public_ip" {
  value = aws_instance.mongodb.public_ip
}

output "backup_bucket_name" {
  value = aws_s3_bucket.backup.id
}

output "alb_dns_name" {
  value = kubernetes_ingress_v1.tasky_ingress.status.0.load_balancer.0.ingress.0.hostname
}