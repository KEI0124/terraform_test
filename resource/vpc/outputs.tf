output vpc_id {
  description = "VPCのID"
  value       = aws_vpc.this.id
}

output vpc_cidr_block {
  description = "VPCのCIDRブロック"
  value       = aws_vpc.this.cidr_block
}
