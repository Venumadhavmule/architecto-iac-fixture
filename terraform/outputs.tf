output "bucket_name" {
  description = "Demo bucket name."
  value       = aws_s3_bucket.logs.bucket
}

output "instance_id" {
  description = "Demo instance id."
  value       = aws_instance.web.id
}

