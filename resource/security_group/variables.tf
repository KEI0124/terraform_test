variable "vpc_id" {
  description = "セキュリティグループを作成するVPC ID"
  type        = string
}

variable "name" {
  description = "セキュリティグループ名。同一アカウント内で一意になる必要がある"
  type        = string
}

variable "description" {
  description = "セキュリティグループの詳細説明"
  type        = string
  default     = "Managed by Terraform"
}

variable "ingress_rule" {
  description = "セキュリティグループのインバウンドルール。マップで指定する。指定の方法はUsageを参照"
  default     = {}
}

variable "egress_rule" {
  description = "セキュリティグループのアウトバウンドルール。マップで指定する"
  default = {
    default = {
      description              = null
      from_port                = 0,
      to_port                  = 0,
      protocol                 = "-1"
      cidr_blocks              = ["0.0.0.0/0"]
      source_security_group_id = null
    }
  }
}

variable "tags" {
  description = "セキュリティグループのタグ"
  type        = map(string)
  default     = {}
}

