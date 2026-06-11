terraform {
  required_version = ">= 1.6.0"

  backend "remote" {
    organization = "architecto-demo"

    workspaces {
      name = "architecto-fixture-dev"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

provider "aws" {
  alias  = "east"
  region = "us-east-1"
}
