variable "key_name" {
  description = "キーペア名"
  type        = string
}

variable "ssh_public_key_path" {
  description = "パブリックキーのディレクトリパス \n 例 `/secrets`"
  type        = string
}

variable "generate_ssh_key" {
  description = "trueなら新しくキーを作成する"
  type        = bool
  default     = false
}

variable "ssh_key_algorithm" {
  description = "SSHキー生成アルゴリズム。 \n RSA、ECDSAが設定可能"
  type        = string
  default     = "RSA"
}

variable "private_key_extension" {
  description = "プライベートキーの拡張子"
  type        = string
  default     = ".pem"
}

variable "public_key_extension" {
  description = "パブリックキーの拡張子"
  type        = string
  default     = ".pub"
}

variable "tags" {
  description = "キーにアタッチするタグ"
  type        = map(string)
  default     = {}
}
