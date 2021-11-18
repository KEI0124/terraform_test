
output "id" {
  description = "インスタンスでIDリスト"
  value       = aws_instance.this.*.id
}

output "arn" {
  description = "インスタンスでARNリスト"
  value       = aws_instance.this.*.arn
}

output "availability_zone" {
  description = "インスタンスAZリスト"
  value       = aws_instance.this.*.availability_zone
}

output "placement_group" {
  description = "placement groupsリスト"
  value       = aws_instance.this.*.placement_group
}

output "key_name" {
  description = "キーペアリスト"
  value       = aws_instance.this.*.key_name
}

output "password_data" {
  description = "Base64で暗号化されたパスワードデータ"
  value       = aws_instance.this.*.password_data
}

output "public_dns" {
  description = "インスタンスのPublic DNS名"
  value       = aws_instance.this.*.public_dns
}

output "public_ip" {
  description = "インスタンスに関連付けされたPublic IP"
  value       = aws_instance.this.*.public_ip
}

output "ipv6_addresses" {
  description = "インスタンスのIPv6アドレス"
  value       = aws_instance.this.*.ipv6_addresses
}

output "primary_network_interface_id" {
  description = "プライマリNIC ID"
  value       = aws_instance.this.*.primary_network_interface_id
}

output "private_dns" {
  description = "インスタンスのprivate DNS名"
  value       = aws_instance.this.*.private_dns
}

output "private_ip" {
  description = "インスタンスに関連付けされたPrivate IPアドレス"
  value       = aws_instance.this.*.private_ip
}

output "security_groups" {
  description = "セキュリティグループID"
  value       = aws_instance.this.*.security_groups
}

output "vpc_security_group_ids" {
  description = "セキュリティグループIDリスト"
  value       = aws_instance.this.*.vpc_security_group_ids
}

output "subnet_id" {
  description = "サブネットID"
  value       = aws_instance.this.*.subnet_id
}

output "credit_specification" {
  description = "クレジット指定値"
  value       = aws_instance.this.*.credit_specification
}

output "instance_state" {
  description = "インスタンス状態"
  value       = aws_instance.this.*.instance_state
}

output "root_block_device_volume_ids" {
  description = "ルードボリュームID"
  value       = [for device in aws_instance.this.*.root_block_device : device.*.volume_id]
}

output "ebs_block_device_volume_ids" {
  description = "EBSボリュームID"
  value       = [for device in aws_instance.this.*.ebs_block_device : device.*.volume_id]
}

output "tags" {
  description = "タグ"
  value       = aws_instance.this.*.tags
}

output "volume_tags" {
  description = "ボリュームタグ"
  value       = aws_instance.this.*.volume_tags
}

output "instance_count" {
  description = "インスタンス数"
  value       = var.instance_count
}
