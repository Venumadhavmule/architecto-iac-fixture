resource "aws_s3_bucket" "logs" {
  bucket = "${var.project_name}-logs-demo"

  tags = {
    Environment = "dev"
    Owner       = "architecto"
  }
}

resource "aws_s3_bucket_acl" "logs_public_read" {
  bucket = aws_s3_bucket.logs.id
  acl    = "public-read"
}

resource "aws_s3_bucket_versioning" "logs" {
  bucket = aws_s3_bucket.logs.id

  versioning_configuration {
    status = "Enabled"
  }
}

data "aws_ami" "al2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}

module "network" {
  source = "./modules/network"

  project_name = var.project_name
  cidr_block   = var.vpc_cidr_block
}

module "external_labels" {
  source  = "cloudposse/label/null"
  version = "0.25.0"

  namespace = "architecto"
  stage     = "dev"
  name      = var.project_name
}

resource "aws_security_group" "web" {
  name        = "${var.project_name}-web"
  description = "Demo security group for import scanning"
  vpc_id      = module.network.vpc_id

  ingress {
    description = "Intentional wide demo ingress for scanner validation"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web" {
  ami                    = data.aws_ami.al2023.id
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.web.id]
  subnet_id              = module.network.public_subnet_id
  depends_on             = [aws_s3_bucket_versioning.logs]

  tags = {
    Name = "${var.project_name}-web"
  }
}

resource "aws_instance" "worker_dev" {
  provider      = aws.east
  ami           = data.aws_ami.al2023.id
  instance_type = "t3.xlarge"
  subnet_id     = module.network.public_subnet_id

  tags = {
    Name        = "${var.project_name}-worker-dev"
    Environment = "dev"
  }
}

resource "aws_ebs_volume" "legacy_data" {
  availability_zone = "${var.aws_region}a"
  size              = 100
  type              = "gp2"
  encrypted         = false

  tags = {
    Name = "${var.project_name}-legacy-data"
  }
}

resource "aws_volume_attachment" "legacy_data_web" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.legacy_data.id
  instance_id = aws_instance.web.id
}

resource "aws_db_instance" "orders" {
  identifier             = "${var.project_name}-orders"
  engine                 = "postgres"
  engine_version         = "16.3"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  storage_encrypted      = false
  username               = "demo_admin"
  password               = "ChangeMe123!"
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.web.id]
}

resource "aws_iam_role" "app" {
  name = "${var.project_name}-app"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy" "wildcard_demo" {
  name = "${var.project_name}-wildcard-demo"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "*"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "app_wildcard" {
  role       = aws_iam_role.app.name
  policy_arn = aws_iam_policy.wildcard_demo.arn
}

moved {
  from = aws_instance.old_web
  to   = aws_instance.web
}

import {
  to = aws_s3_bucket.logs
  id = "${var.project_name}-logs-demo"
}
