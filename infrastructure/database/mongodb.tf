resource "aws_instance" "mongodb" {
  ami                    = "ami-0a49b025fffbbdac6" # Ubuntu 18.04
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.mongodb.id]
  key_name               = aws_key_pair.ssh.key_name
  
  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y mongodb=1:2.6.10
              systemctl start mongodb
              EOF
}

resource "aws_security_group" "mongodb" {
  name_prefix = "mongodb-sg-"
  
  ingress {
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_iam_instance_profile" "mongodb" {
  name = "mongodb-instance-profile"
  role = aws_iam_role.mongodb.name
}

resource "aws_iam_role" "mongodb" {
  name = "mongodb-role"

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

resource "aws_iam_role_policy_attachment" "mongodb_admin" {
  role       = aws_iam_role.mongodb.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}