output "alb_target_group_arn" {
  description = "ロードバランサのターゲットグループのARN" 
  value       = aws_alb_target_group.this.arn
}

output "alb_dns_name" {
  description = "ロードバランサのDNS名" 
  value       = aws_alb.this.dns_name
}