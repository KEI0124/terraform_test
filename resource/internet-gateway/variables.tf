variable internet_gateway_name {
  description = "Internet Gatewayの名前"
  type        = string
  default     = null
}

variable vpc_id {
  description = "Internet GatewayをアタッチするVPCのID"
  type        = string
}

variable tags {
  description = "リソースに割り当てるタグのマップ"
  type        = map(string)
  default     = {}
}

