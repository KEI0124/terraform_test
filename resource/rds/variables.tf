variable "identifier" {
  description = "DB識別子"
  type        = string
}

variable "tags" {
  description = "リソースに紐付けるタグ"
  type        = map(string)
  default     = {}
}

variable "security_group_ids" {
  description = "アタッチするセキュリティグループのIDリスト"
  type        = list(string)
}

variable "database_name" {
  description = "DBインスタンスが作られたときにデータベースにつける名前"
  type        = string
  default     = ""
}

variable "database_user" {
  description = " マスターDBのユーザ名\n(snapshot_identifierか、replicate_source_dbが有効でない場合は設定必須。)"
  type        = string
  default     = ""
}

variable "database_password" {
  description = "マスターDBのパスワード\n(snapshot_identifierか、replicate_source_dbが有効でない場合は設定必須。) "
  type        = string
  default     = ""
}

variable "database_port" {
  description = "DBポート(例： `MySQL`→`3306`)"
  type        = number
}

variable "deletion_protection" {
  description = "RDSインスタンスの削除防止をするか"
  type        = bool
  default     = false
}

variable "multi_az" {
  description = "マルチAZ"
  type        = bool
  default     = false
}

variable "storage_type" {
  description = "ストレージタイプ。設定可能値：　'standard' (magnetic), 'gp2' (general purpose SSD), 'io1' (provisioned IOPS SSD)"
  type        = string
  default     = "standard"
}

variable "storage_encrypted" {
  description = "ストレージを暗号化するかどうか"
  type        = bool
  default     = false
}

variable "iops" {
  description = "プロビジョンドIOPSの値。storage_typeが'io1'のときに設定する。"
  type        = number
  default     = 0
}

variable "allocated_storage" {
  description = "割り当てられたストレージ量(GB)"
  type        = number
}

variable "max_allocated_storage" {
  description = "自動で拡張されるストレージの最大リミット(GB)"
  type        = number
  default     = 0
}

variable "engine" {
  description = "データベースエンジンタイプ。\n 設定可能値は[公式](https://docs.aws.amazon.com/AmazonRDS/latest/APIReference/API_CreateDBInstance.html)の(Engineセクション)を参照。"
  type        = string
}

variable "engine_version" {
  description = "データベースエンジンバージョン。\n 設定可能値は[公式](https://docs.aws.amazon.com/AmazonRDS/latest/APIReference/API_CreateDBInstance.html)の(EngineVersionセクション)を参照。"
  type        = string
}

variable "major_engine_version" {
  description = "データベースメジャーエンジンバージョン。\nlocalsにより自動で計算されるので、設定は必須ではない。"
  type        = string
  default     = ""
}

variable "license_model" {
  description = "ライセンスモデル。Oracleでは設定必須。 設定可能値: license-included | bring-your-own-license | general-public-license"
  type        = string
  default     = ""
}

variable "instance_class" {
  description = "RDSインスタンスクラス\n詳細は[公式](https://docs.aws.amazon.com/ja_jp/AmazonRDS/latest/UserGuide/Concepts.DBInstanceClass.html)を参照"
  type        = string
}


variable "publicly_accessible" {
  description = "パブリックアクセスを可能にするか"
  type        = bool
  default     = false
}

variable "subnet_ids" {
  description = "サブネットIDのリスト"
  type        = list(string)
}

variable "auto_minor_version_upgrade" {
  description = "マイナーバージョンの自動アップデートをするか。(e.g. Postgres 9.5.3 → Postgres 9.5.4)"
  type        = bool
  default     = true
}

variable "allow_major_version_upgrade" {
  description = "メジャーバージョンのアップグレードを許可するか"
  type        = bool
  default     = false
}

variable "apply_immediately" {
  description = "データーベースへの変更を即座に反映するか。falseならメンテナンスウィンドウで反映される。"
  type        = bool
  default     = false
}

variable "maintenance_window" {
  description = "メンテナンス時間　記載方法: 'ddd:hh24:mi-ddd:hh24:mi' UTC "
  type        = string
}

variable "skip_final_snapshot" {
  description = "trueの場合,DB削除時にスナップショットが作成されない"
  type        = bool
  default     = true
}

variable "copy_tags_to_snapshot" {
  description = "スナップショットにDBのタグを付与するか"
  type        = bool
  default     = true
}

variable "backup_retention_period" {
  description = "バックアップ取得間隔(日)。 0以上でバックアップ有効"
  type        = number
  default     = 0
}

variable "backup_window" {
  description = "AWSがDBスナップショットをとる時間、メンテンスウィンドウと重複不可。"
  type        = string
}

variable "db_parameter_group" {
  description = "パラメータグループ。DBエンジンによって異なる。\n省略するとデフォルトのパラメータグループが作成され適用される。"
  type        = string
  default     = null
}

variable "db_parameter" {
  type = list(object({
    name         = string
    value        = string
    apply_method = string
  }))
  description = "DBパラメータのリスト。DBエンジンの種類によって設定できる値が異なる。\nこの値を設定すると、db_parameter_groupで指定されたパラメータグループに上書きして新規のパラメータグループを作成する"
  default     = []
}

variable "db_option_group_name" {
  description = "オプショングループ名。新規作成せずに既存のものを使う場合に指定する。\ndb_optionsが指定されている場合は無視される。"
  type        = string
  default     = null
}

variable "db_options" {
  description = "DBオプションのリスト。DBエンジンの種類によって設定できる値が異なる。\n詳細な設定内容は[Terraformドキュメント](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_option_group)を参照\n設定できるオプションは[AWS公式ドキュメント](https://docs.aws.amazon.com/ja_jp/AmazonRDS/latest/UserGuide/USER_WorkingWithOptionGroups.html)を参照"
  default     = []
}

variable "snapshot_identifier" {
  description = "復元するスナップショット識別子。\n設定された場合、スナップショットからDBを作成する"
  type        = string
  default     = ""
}

variable "final_snapshot_identifier" {
  description = "最終スナップショット識別子。\n skip_final_snapshotがfalseの場合は設定必須"
  type        = string
  default     = null
}

variable "parameter_group_name" {
  description = "関連付けるDBパラメータグループ名"
  type        = string
  default     = ""
}

variable "option_group_name" {
  description = "関連付けるDBオプショングループ名"
  type        = string
  default     = ""
}

variable "kms_key_arn" {
  description = "ストレージ暗号化のためのKMSキーARN"
  type        = string
  default     = ""
}

variable "performance_insights_enabled" {
  description = "パフォーマンスインサイトを有効化するか"
  type        = bool
  default     = false
}

variable "performance_insights_kms_key_id" {
  description = "パフォーマンスインサイトデータを暗号化するKMSキーARN. KMSキーが設定された場合、後から変更不可"
  type        = string
  default     = null
}

variable "performance_insights_retention_period" {
  description = "パフォーマンスインサイトデータの保持期間。  7 (7日) or 731 (2年)のどちらか."
  type        = number
  default     = 7
}

variable "enabled_cloudwatch_logs_exports" {
  description = "CloudWatch logsにエクスポートするログ種別のリスト。\n省略された場合、ログは出力されない。\n 設定可能値 (DBエンジンの種類による): alert, audit, error, general, listener, slowquery, trace, postgresql (PostgreSQL), upgrade (PostgreSQL)."
  type        = list(string)
  default     = []
}

variable "ca_cert_identifier" {
  description = "DBインスタンスのCA証明書の識別子"
  type        = string
  default     = "rds-ca-2019"
}

variable "monitoring_interval" {
  description = "拡張モニタリングのメトリクス収集間隔(秒)。 0で拡張モニタリング無効。\n 設定可能値： 0, 1, 5, 10, 15, 30, 60."
  type        = number
  default     = 0
}


variable "iam_database_authentication_enabled" {
  description = "DBへのアクセスにIAMを使える機能。RDS Auroraのみ設定可能。"
  type        = bool
  default     = false
}
