output "bucket_name" {
  description = "Demo bucket name."
  value       = aws_s3_bucket.logs.bucket
}

output "instance_id" {
  description = "Demo instance id."
  value       = aws_instance.web.id
}

output "vpc_id" {
  description = "Demo VPC id from child module."
  value       = module.network.vpc_id
}

output "database_endpoint" {
  description = "Demo RDS endpoint."
  value       = aws_db_instance.orders.endpoint
  sensitive   = true
}
