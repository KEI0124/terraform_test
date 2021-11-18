variable "vpc_id" {
  description = "サブネットを作成するVPCのID"
  type        = string
}

variable "subnets" {
  description = "サブネット設定のマップ。設定の仕方はUsageを参照"
  type = map(object({
    availability_zone = string,
    cidr_block        = string,
    }
  ))
}

variable "map_public_ip_on_launch" {
  description = "サブネット内で起動されたインスタンスにパブリックIPを付与するか"
  type        = string
  default     = false
}

variable "tags" {
  description = "サブネットに割り当てるタグ"
  type        = map(string)
  default     = {}
}
