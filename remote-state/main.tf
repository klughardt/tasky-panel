provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "tasky_terraform_state" {
  bucket = "tfstate"
     
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_versioning" "tasky_terraform_state" {
    bucket = aws_s3_bucket.tasky_terraform_state.id

    versioning_configuration {
      status = "Enabled"
    }
}

resource "aws_dynamodb_table" "tasky_terraform_state_lock" {
  name           = "tasky-app-state"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}