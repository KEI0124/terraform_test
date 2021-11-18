output "autoscaling_group_name" {
  description = "オートスケーリンググループの名前"
  value       = aws_autoscaling_group.this.name
}

output "autoscaling_policy_arn" {
  description = "オートスケーリングポリシーのAmazonリソースネームリスト"
  value       = [for asg in aws_autoscaling_group.this[*] : asg.arn]
}