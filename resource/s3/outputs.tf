output "s3_bucket_id" {
  description = "S3バケットのID"
  value       = aws_s3_bucket.this.id
}
 
output "s3_bucket_arn" {
  description = "S3バケットのARN"
  value       = aws_s3_bucket.this.arn
}
