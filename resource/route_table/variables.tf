variable route_table_name {
  description = "ルートテーブル名"
  type        = string
  default     = null
}

variable vpc_id {
  description = "ルートテーブルを関連付けるVPCのID"
  type        = string
}

variable route {
  description = "ルートオブジェクトのリスト"
  type        = list(map(string))
}

variable subnet_ids {
  description = "ルートテーブルに関連付けるサブネットIDのリスト"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "リソースに割り当てるタグのマップ"
  type        = map(string)
  default     = {}
}
