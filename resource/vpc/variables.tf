variable vpc_name {
  description = "VPCの名前"
  type        = string
}

variable cidr_block {
  description = "VPCのCIDRブロック。(例)10.0.0.0/16"
  type        = string
}

variable enable_dns_support {
  description = "VPCでDNSサポートを有効/無効にするブール値。デフォルトは`true`"
  type        = bool
  default     = true
}

variable enable_dns_hostnames {
  description = "VPCでDNSホスト名を有効/無効にするブール値。デフォルトは`false`"
  type        = bool
  default     = false
}

variable tags {
  description = "リソースに割り当てるタグのマップ"
  type        = map(string)
  default     = {}
}