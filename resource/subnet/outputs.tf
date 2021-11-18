output "subnet_ids" {
  description = "サブネットIDのリスト"
  value       = [for subnet in aws_subnet.this : subnet.id]
}

