variable "aws_region" {
  description = "Demo AWS region for cost and resource parsing."
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Name prefix for demo resources."
  type        = string
  default     = "architecto-fixture"
}

variable "vpc_cidr_block" {
  description = "CIDR range for fixture networking."
  type        = string
  default     = "10.42.0.0/16"
}
