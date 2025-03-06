variable "region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "aws_secondary_region" {
  type        = string
  default     = "us-west-1"
}

variable "cluster_name" {
  default = "wiz-exercise-cluster"
}

variable "mongodb_ami" {
  default = "ami-0a49b025fffbbdac6" # Ubuntu 18.04
}

variable "ec2_key_name" {
  default = "wiz-ssh-key"
}

variable "project_name" {
  default = "tasky-panel"
}

variable "db_user" {
  default = "dbadmin"
}

variable "db_pass" {
  sensitive = true
  type = string
}