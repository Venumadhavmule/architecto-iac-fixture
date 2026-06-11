resource "aws_s3_bucket" "logs" {
  bucket = "${var.project_name}-logs-demo"

  tags = {
    Environment = "dev"
    Owner       = "architecto"
  }
}

resource "aws_s3_bucket_versioning" "logs" {
  bucket = aws_s3_bucket.logs.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_security_group" "web" {
  name        = "${var.project_name}-web"
  description = "Demo security group for import scanning"

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
  ami                    = "ami-0c02fb55956c7d316"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.web.id]

  tags = {
    Name = "${var.project_name}-web"
  }
}

