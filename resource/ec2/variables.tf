variable "name" {
  description = "すべてのインスタンスにプレフィックスとしてつけられる名前"
  type        = string
}

variable "instance_count" {
  description = "起動インスタンス数"
  type        = number
  default     = 1
}

variable "ami" {
  description = "インスタンスに使用するAMI ID"
  type        = string
}

variable "placement_group" {
  description = "インスタンス開始時のプレースメントグループ"
  type        = string
  default     = ""
}

variable "get_password_data" {
  description = "true の場合、パスワードデータが利用可能になる。\n [詳細説明](https://www.terraform.io/docs/providers/aws/r/instance.html#get_password_data)を参照ください。"
  type        = bool
  default     = false
}

variable "tenancy" {
  description = "インスタンスのテナント設定値: default, dedicated, host"
  type        = string
  default     = "default"
}

variable "ebs_optimized" {
  description = "trueの場合、インスタンスがEBSに最適化されます。\n [詳細参照](https://docs.aws.amazon.com/ja_jp/AWSEC2/latest/UserGuide/ebs-optimized.html)"
  type        = bool
  default     = false
}

variable "disable_api_termination" {
  description = "trueの場合、インスタンス削除から保護"
  type        = bool
  default     = false
}

# https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/terminating-instances.html#Using_ChangingInstanceInitiatedShutdownBehavior
variable "instance_initiated_shutdown_behavior" {
  description = "インスタンスシャットダウン時の動作指定、設定値: stop, terminate"
  type        = string
  default     = ""
}

variable "instance_type" {
  description = "インスタンスタイプ指定"
  type        = string
}

variable "key_name" {
  description = "インスタンスで使うキーペア名"
  type        = string
  default     = ""
}

variable "monitoring" {
  description = "trueの場合、EC2インスタンスの詳細モニタリングが有効"
  type        = bool
  default     = false
}

variable "vpc_security_group_ids" {
  description = "関連付けるセキュリティグループIDのリスト"
  type        = list(string)
  default     = null
}

variable "subnet_id" {
  description = "起動時のサブネットID"
  type        = string
  default     = ""
}

variable "subnet_ids" {
  description = "起動時のサブネットIDリスト"
  type        = list(string)
  default     = []
}

variable "associate_public_ip_address" {
  description = "trueの場合、パブリックIPを関連付けする。"
  type        = bool
  default     = null
}

variable "private_ip" {
  description = "インスタンスに関連付けるプライベートIP"
  type        = string
  default     = null
}

variable "private_ips" {
  description = "インスタンスに関連付けるプライベートIPリスト"
  type        = list(string)
  default     = []
}

variable "source_dest_check" {
  description = "宛先アドレスがインスタンスと一致しない場合、ルーティングするかを制御。NATまたはVPNで使用。既定値：true"
  type        = bool
  default     = true
}

variable "user_data" {
  description = "インスタンス起動時のユーザデータ、gzipデータ禁止"
  type        = string
  default     = null
}

variable "user_data_base64" {
  description = "base64でエンコードされたバイナリデータを直接渡すことができる。"
  type        = string
  default     = null
}

variable "role" {
  description = "IAMインスタンスプロファイルにアタッチするIAMロール名"
  type        = string
  default     = null
}

variable "path" {
  description = "IAMロールのパス"
  type        = string
  default     = "/"

}

variable "ipv6_address_count" {
  description = "プライマリNICに関連付けるIPv6アドレスの数"
  type        = number
  default     = null
}

variable "ipv6_addresses" {
  description = "プライマリNICから1つ以上のIPv6アドレスを指定"
  type        = list(string)
  default     = null
}

variable "tags" {
  description = "リソースに追加するTAG値"
  type        = map(string)
  default     = {}
}

variable "volume_tags" {
  description = "ボリュームタグマッピング"
  type        = map(string)
  default     = {}
}

variable "root_block_device" {
  description = "ルートブロックデバイス、\n [詳細参照](https://www.terraform.io/docs/providers/aws/r/instance.html#block-devices)"
  type        = list(map(string))
  default     = []
}

variable "ebs_block_device" {
  description = "インスタンスに追加でアタッチするEBS"
  type        = list(map(string))
  default     = []
}

variable "ephemeral_block_device" {
  description = "インスタンスストアのカスタマイズ、\n [詳細参照](https://www.terraform.io/docs/providers/aws/r/instance.html#block-devices)"
  type        = list(map(string))
  default     = []
}

variable "network_interface" {
  description = "インスタンス起動時にアタッチするNIC、\n [詳細参照](https://www.terraform.io/docs/providers/aws/r/instance.html#network-interfaces)"
  type        = list(map(string))
  default     = []
}

variable "cpu_credits" {
  description = "CPUクレジットオプション、設定値: unlimited、standard"
  type        = string
  default     = "standard"
}

variable "use_num_suffix" {
  description = "１つのインスタンスでもインスタンス名に数値を付ける。"
  type        = bool
  default     = false
}
