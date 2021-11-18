output "instance_id" {
  description = "RDSインスタンスID"
  value       = aws_db_instance.this.id
}

output "instance_arn" {
  description = "RDSインスタンスARN"
  value       = aws_db_instance.this.arn
}

output "instance_endpoint" {
  description = "RDSDNSエンドポイント"
  value       = aws_db_instance.this.endpoint
}