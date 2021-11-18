# --------------------------------------------------------------------------------
# aws_launch_template resource variables
# --------------------------------------------------------------------------------

variable "launch_template_name" {
  description = "起動テンプレートの名前"
  type        = string
  default     = null
}

variable "block_device_mappings" {
  description = "AMIで指定されたボリュームの他に、インスタンスに接続するボリュームを指定する"
  type        = any
  default     = null
}

variable "image_id" {
  description = "インスタンスを起動するAMI"
  type        = string
  default     = null
}

variable "instance_type" {
  description = "インスタンスのタイプ\n例)：t2.micro"
  type        = string
  default     = null
}

variable "key_name" {
  description = "インスタンスに使用するキー名"
  type        = string
  default     = null
}

variable "user_data" {
  description = "インスタンスの起動時に提供するBase64でエンコードされたユーザーデータ"
  type        = string
  default     = null
}

variable "instance_profile_name" {
  description = "インスタンスを起動するIAMインスタンスプロファイル"
  type        = string
  default     = null
}

variable "device_index" {
  description = "ネットワークインターフェイスアタッチメントの整数インデックス"
  type        = number
  default     = 0
}

variable "associate_public_ip_address" {
  description = "パブリックIPアドレスをネットワークインターフェイスに関連付ける場合：true、関連付けない場合：false"
  type        = bool
  default     = false
}

variable "eni_delete_on_termination" {
  description = "インスタンスの終了時にネットワークインターフェイスを破棄するかどうか\n破棄する：true、破棄しない：false"
  type        = bool
  default     = false
}

variable "security_group_ids" {
  description = "関連付けるセキュリティグループIDのリスト"
  type        = list(string)
  default     = []
}

variable tags {
  description = "すべてのリソースに追加するタグのマップ値"
  type        = map
  default     = {}
}

# --------------------------------------------------------------------------------
# aws_autoscaling_group resource variables
# --------------------------------------------------------------------------------

variable "autoscaling_group_name" {
  description = "オートスケーリンググループの名前"
  type        = string
  default     = null
}

variable "subnet_ids" {
  description = "リソースを起動するサブネットIDのリスト"
  type        = list(string)
  default     = []
}

variable "max_size" {
  description = "自動スケールグループの最大サイズ"
  type        = number
  default     = null
}

variable "min_size" {
  description = "自動スケールグループの最小サイズ"
  type        = number
  default     = null
}

variable "load_balancers" {
  description = "自動スケーリンググループ名に追加するElastic Load Balancer名のリスト"
  type        = list(string)
  default     = []
}

variable "health_check_grace_period" {
  description = "インスタンスが稼働してからヘルスをチェックするまでの時間（秒単位）"
  type        = number
  default     = 300
}

variable "health_check_type" {
  description = "ヘルスチェックの実行方法を制御する。有効な値は「EC2」または「ELB」です"
  type        = string
  default     = null
}

variable "desired_capacity" {
  description = "グループで実行する必要があるEC2インスタンスの数"
  type        = number
  default     = null
}

variable "min_elb_capacity" {
  type        = number
  description = "この数のインスタンスが作成時にのみELBで正常に表示されるまで待機します。"
  default     = 0
}

variable "wait_for_elb_capacity" {
  description = "作成操作と更新操作の両方で、接続されているすべてのロードバランサーでこの数の正常なインスタンスを待機します"
  type        = number
  default     = 0
}

variable "target_group_arns" {
  description = "アプリケーションまたはネットワーク負荷分散で使用するaws_alb_target_group ARNのリスト"
  type        = list(string)
  default     = []
}

variable "default_cooldown" {
  description = "スケーリングアクティビティと後続のスケーリングアクティビティの間の時間"
  type        = number
  default     = 300
}

variable "force_delete" {
  description = "プール内のすべてのインスタンスが終了するのを待たずに、自動スケーリンググループを削除できます"
  type        = bool
  default     = false
}

variable "termination_policies" {
  description = "自動スケールグループ内のインスタンスを終了する方法を決定するポリシーのリスト"
  type        = list(string)
  default     = []
}

variable "suspended_processes" {
  description = "AutoScalingグループのために一時停止するプロセスのリスト"
  type        = list(string)
  default     = []
}

variable "placement_group" {
  description = "インスタンスを起動するプレースメントグループの名前"
  type        = string
  default     = null
}

variable "enabled_metrics" {
  description = "収集するメトリックのリスト。\n許可される値は、 `GroupMinSize`、` GroupMaxSize`、 `GroupDesiredCapacity`、` GroupInServiceInstances`、 `GroupPendingInstances`、` GroupStandbyInstances`、 `GroupTerminatingInstances`、` GroupTotalInstances`です。"
  type        = list(string)
  default = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupPendingInstances",
    "GroupStandbyInstances",
    "GroupTerminatingInstances",
    "GroupTotalInstances",
  ]
}

variable "metrics_granularity" {
  description = "収集するメトリックに関連付ける粒度。有効な値は1分のみです"
  type        = string
  default     = "1Minute"
}

variable "wait_for_capacity_timeout" {
  description = "Terraformがタイムアウトする前にASGインスタンスが正常になるまで待機する最大時間"
  type        = string
  default     = "10m"
}

variable "protect_from_scale_in" {
  description = "インスタンス保護を設定できます。自動スケーリンググループは、この設定のインスタンスを、イベントのスケーリング中の終了に選択しません"
  type        = bool
  default     = null
}

variable "service_linked_role_arn" {
  description = "ASGが他のAWSサービスを呼び出すために使用するサービスにリンクされたロールのARN"
  type        = string
  default     = null
}

variable "instance_name" {
  description = "EC2インスタンスの名前タグ"
  type        = string
  default     = null
}

locals {
  tags = merge(var.tags, { "Name" = var.instance_name })
}

# --------------------------------------------------------------------------------
# aws_autoscaling_attachment resource variables
# --------------------------------------------------------------------------------

variable "alb_target_group_arn" {
  description = "ALBターゲットグループのARN"
  type        = string
  default     = null
}

# --------------------------------------------------------------------------------
# aws_autoscaling_attachment resource variables
# --------------------------------------------------------------------------------

variable "autoscaling_policies" {
  description = "自動スケーリングポリシー変数のリスト"
  type        = any
  default     = {}
}
