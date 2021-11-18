# --------------------------------------------------------------------------------
# aws_alb resource variables
# --------------------------------------------------------------------------------

variable alb_name {
  description = "ロードバランサの名前"
  type        = string
  default     = null
}

variable load_balancer_type {
  description = "作成するロードバランサのタイプ。設定可能な値は、`application`または`network`。デフォルト値は`application`"
  type        = string
  default     = "application"
}

variable internal {
  description = "ロードバランサを内部LBにする（true）か、しない（false）を決定するブール値"
  type        = bool
  default     = false
}

variable security_groups {
  description = "ロードバランサに割り当てるセキュリティグループIDのリスト。\nApplicationタイプのロードバランサに対してのみ設定可能"
  type        = list(string)
  default     = []
}

variable subnets {
  description = "ロードバランサに接続するサブネットIDのリスト"
  type        = list(string)
  default     = []
}

variable idle_timeout {
  description = "接続がアイドル状態でいられる秒単位の時間。\nApplicationタイプのロードバランサに対してのみ設定可能。\nデフォルトは60秒"
  type        = number
  default     = 60
}

variable enable_cross_zone_load_balancing {
  description = "ロードバランサのゾーン間負荷分散を有効にする（true）、しない（false）を決定するブール値。デフォルトはfalse"
  type        = bool
  default     = false
}

variable enable_deletion_protection {
  description = "AWS APIを介したロードバランサの削除を無効にする（true）、しない（false）を決定するブール値。\ntrueの場合、terraformがロードバランサを削除出来なくなる。デフォルトはfalse"
  type        = bool
  default     = false
}

variable enable_http2 {
  description = "ApplicationタイプのロードバランサでHTTP/2が有効になっているかを示すブール値。デフォルトはtrue"
  type        = bool
  default     = true
}

variable ip_address_type {
  description = "ロードバランサのサブネットで使用されるIPアドレスのタイプ。設定可能な値は`ipv4`、または`dualstack`。デフォルト値は`ipv4`"
  type        = string
  default     = "ipv4"
}

variable drop_invalid_header_fields {
  description = "無効なヘッダーフィールドを持つHTTPヘッダがロードバランサによって削除されるか（true）、ターゲットにルーティングされるか（false）を決定するブール値。\nApplicationタイプのロードバランサに対してのみ設定可能。\nデフォルトはfalse"
  type        = bool
  default     = false
}

variable "access_logs" {
  description = "ロードバランサのアクセスログ出力を設定するリスト。\naccess_logsの詳細な設定値は[ドキュメント](https://www.terraform.io/docs/providers/aws/r/lb.html#access_logs)を参照ください"
  type        = list(map(string))
  default     = []
}

variable tags {
  description = "リソースに割り当てるタグのマップ"
  type        = map(string)
  default     = {}
}

# --------------------------------------------------------------------------------
# aws_alb_target_group resource variables
# --------------------------------------------------------------------------------

variable target_group_name {
  description = "ターゲットグループの名前"
  type        = string
  default     = null
}

variable vpc_id {
  description = "ターゲットグループを作成するVPCの識別子。\n`target_type`に`instance`、または`ip`を指定した場合は必須項目。\n`target_type`に`lambda`を指定した場合は適用されない"
  type        = string
  default     = null
}

variable target_port {
  description = "ターゲットがトラフィックを受信するポート。\n`target_type`に`instance`、または`ip`を指定した場合は必須項目。\n`target_type`に`lambda`を指定した場合は適用されない"
  type        = number
  default     = null
}

variable target_protocol {
  description = "ターゲットへのトラフィックのルーティングに使用するプロトコル。設定可能な値は、`TCP`、`TLS`、`UDP`、`TCP_UDP`、`HTTP`、``、`HTTPS`。\n`target_type`に`instance`、または`ip`を指定した場合は必須項。\n`target_type`に`lambda`を指定した場合は適用されない"
  type        = string
  default     = null
}

variable target_type {
  description = "ターゲットグループにターゲットを登録するときに指定する必要があるターゲットのタイプ。設定可能な値は、`instance`、`ip`、または`lambda`。デフォルト値は`instance`"
  type        = string
  default     = "instance"
}

variable deregistration_delay {
  description = "ロードバランサが登録を解除するターゲットの状態をド​​レインから未使用に変更するまで待機する秒単位の時間。設定可能な値の範囲は0〜3600秒。デフォルト値は300秒"
  type        = number
  default     = 300
}

variable slow_start {
  description = "ロードバランサがリクエストの完全なシェアを送信する前にターゲットがウォームアップする秒単位の時間。設定可能な値の範囲は30〜900秒。無効にする場合は0を指定する。デフォルト値は0秒"
  type        = number
  default     = 0
}

variable proxy_protocol_v2 {
  description = "Networkロードバランサがプロキシプロトコルv2のサポートを有効、または無効にするブール値。詳細は[ドキュメント](https://docs.aws.amazon.com/elasticloadbalancing/latest/network/load-balancer-target-groups.html#proxy-protocol)を参照ください"
  type        = bool
  default     = false
}

variable lambda_multi_value_headers_enabled {
  description = "ロードバランサとLambda関数の間で交換される要求ヘッダと応答ヘッダに値の配列、または文字列が含まれるかどうかを示すブール値。`target_type`に`lambda`を指定した場合のみ適用される"
  type        = bool
  default     = false
}

variable enabled {
  description = "ヘルスチェックが有効かどうかを示すブール値。デフォルト値は`true`"
  type        = bool
  default     = true
}

variable interval {
  description = "個々のターゲットのヘルスチェック間隔（秒単位）。最小値5秒、最大値300秒。デフォルト値は30秒"
  type        = number
  default     = 30
}

variable path {
  description = "ヘルスチェックリクエストの宛先。Applicationロードバランサに適用され、Network Load Balancersには適用されない"
  type        = string
  default     = null
}

variable health_check_port {
  description = "ターゲットとの接続に使用するポート。有効な値は、1〜65535ポートのいずれか、またはtraffic-port。デフォルト値はtraffic-port"
  type        = string
  default     = "traffic-port"
}

variable healthy_threshold {
  description = "ターゲットが正常であると見なす前に必要な連続したヘルスチェックの成功回数。デフォルト値は3"
  type        = number
  default     = 3
}

variable unhealthy_threshold {
  description = "ターゲットが異常と見なす前に必要な連続的なヘルスチェックの失敗回数。Networkロードバランサの場合は、healthy_thresholdと同じ値である必要がある。デフォルト値は3"
  type        = number
  default     = 3
}

variable timeout {
  description = "ヘルスチェックが失敗とみなす秒単位の時間。Applicationロードバランサの場合、設定可能な値の範囲は2〜120秒で、デフォルト値はinstanceターゲットタイプの場合は5秒、lambdaターゲットタイプの場合は30秒。Networkロードバランサーの場合、カスタム値を設定することはできない。デフォルト値は、TCP、またはHTTPSの場合は10秒、HTTPの場合は6秒"
  type        = number
  default     = null
}

variable health_check_protocol {
  description = "ターゲットとの接続に使用するプロトコル。デフォルト値はHTTP。target_typeがlambdaの場合は適用されない"
  type        = string
  default     = "HTTP"
}

variable matcher {
  description = "ターゲットからの正常な応答を確認するときに使用するHTTPコード。複数の値（たとえば、「200,202」）、または値の範囲（たとえば、「200-299」）を指定可能。Applicationロードバランサのみ（HTTP / HTTPS）に適用され、Networkロードバランサ（TCP）には適用されない"
  type        = number
  default     = null
}

#variable target_id {
#  description = "ターゲットグループに紐付けるインスタンス"
#  type = string
#}

# --------------------------------------------------------------------------------
# aws_alb_listener resource variables
# --------------------------------------------------------------------------------

variable listener_port {
  description = "ロードバランサーがリッスンしているポート"
  type        = string
}

variable listener_protocol {
  description = "クライアントからロードバランサの接続するためのプロトコル。設定可能な値は`TCP`、`TLS`、`UDP`、`TCP_UDP`、`HTTP`、または`HTTPS`。デフォルト値は`HTTP`"
  type        = string
  default     = null
}

variable listener_default_action_type {
  description = "ルーティングアクションのタイプ。設定可能な値は`forward`、`redirect`、`fixed-response`、`authenticate-cognito`、または`authenticate-oidc`"
  type        = string
  default     = "forward"
}

# --------------------------------------------------------------------------------
# aws_alb_listener_rule resource variables
# --------------------------------------------------------------------------------

variable listener_rule_priority {
  description = "ルールの優先順位。未設定の場合は現在存在する最も高いルールの後に、次に利用可能な優先度でルールが自動的に設定される。リスナーは、同じ優先度を持つ複数のルールを設定することは出来ない"
  type        = number
  default     = null
}


variable listener_rule_action_type {
  description = "ルーティングアクションのタイプ。設定可能な値は`forward`、`redirect`、`fixed-response`、`authenticate-cognito`、または`authenticate-oidc`"
  type        = string
  default     = "forward"
}


variable listener_rule_condition_field {
  description = "ルールの条件のタイプ。設定可能な値は、`host-header`、または`path-pattern`。当該項目を設定した場合は、listener_rule_condition_values属性値の設定が必要"
  type        = string
  default     = "path-pattern"
}

variable listener_rule_condition_values {
  description = "ルールの条件に一致するパターンをリスト形式で指定する"
  type        = list
  default     = []
}
