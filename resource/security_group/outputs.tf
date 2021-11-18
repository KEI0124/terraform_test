output "security_group_id" {
  description = "セキュリティグループID"
  value       = aws_security_group.this.id
}

output "security_group_ingress" {
  description = "インバウンドルールのリスト"
  value       = [for rule in aws_security_group.this[*] : rule.ingress]
}

output "security_group_egress" {
  description = "アウトバウンドルールのリスト"
  value       = [for rule in aws_security_group.this[*] : rule.egress]
}
