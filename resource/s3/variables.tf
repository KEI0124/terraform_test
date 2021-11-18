# --------------------------------------------------------------------------------
# aws_s3_bucket resource variables
# --------------------------------------------------------------------------------

variable bucket {
  description = "バケットの名前"
  type        = string
}

variable acl {
  description = "適用するACL名。デフォルト値は`private`"
  type        = string
  default     = "private"
}

variable force_destroy {
  description = "全てのオブジェクト（ロックされたオブジェクトを含む）をバケットから削除して、エラーなくバケットを破棄できることを示すブール値。デフォルト値は`false`"
  type        = bool
  default     = false
}

variable acceleration_status {
  description = "既存のバケットに対してTransfer Accelerationを設定。設定可能な値は、`Enabled`、または`Suspended`"
  type        = string
  default     = null
}

variable region {
  description = "バケットが存在するAWSリージョン"
  type        = string
  default     = null
}

variable request_payer {
  description = "Amazon S3データ転送の費用を誰が負担するかを指定する。設定可能な値は、`BucketOwner`、または`Requester`。デフォルト値は、`BucketOwner`"
  type        = string
  default     = "BucketOwner"
}

variable versioning_enabled {
  description = "バージョン管理を有効にする（true）、しない（false）を決定するブール値。デフォルト値は`false`"
  type        = bool
  default     = false
}

variable versioning_mfa_delete {
  description = "MFA Deleteを有効にする（true）、しない（false）を決定するブール値。デフォルト値は`false`"
  type        = bool
  default     = false
}

variable logging {
  description = "バケットロギングの設定をするリスト。\nloggingの詳細な設定値は[ドキュメント](https://www.terraform.io/docs/providers/aws/r/s3_bucket.html#logging)を参照ください"
  type        = list(map(string))
  default     = []
}

variable server_side_encryption_configuration {
  description = "S3サーバ側の暗号化の設定をするリスト。\nserver_side_encryption_configurationの詳細な設定値は[ドキュメント](https://www.terraform.io/docs/providers/aws/r/s3_bucket.html#server_side_encryption_configuration)を参照ください"
  type        = any
  default     = []
}

variable lifecycle_rule {
  description = "オブジェクトのライフサイクル管理の設定をするリスト。\nlifecycle_ruleの詳細な設定値は[ドキュメント](https://www.terraform.io/docs/providers/aws/r/s3_bucket.html#lifecycle_rule)を参照ください"
  type        = any
  default     = []
}

variable tags {
  description = "リソースに割り当てるタグのマップ"
  type        = map(string)
  default     = {}
}

# --------------------------------------------------------------------------------
# aws_s3_bucket_public_access_block resource variables
# --------------------------------------------------------------------------------

variable block_public_acls {
  description = "バケットのパブリックACLをブロックするかどうかを示すブール値。デフォルト値は`true`。trueの場合、\n指定されたACLがパブリックアクセスを許可している場合、PUT Bucket aclとPUT Object aclの呼び出しが失敗する。\nリクエストにオブジェクトACLが含まれている場合、PUT Object呼び出しが失敗する"
  type        = bool
  default     = true
}

variable block_public_policy {
  description = "バケットのパブリックバケットポリシーをブロックするかどうかを示すブール値。デフォルト値は`true`。trueの場合、\n指定されたバケットポリシーがパブリックアクセスを許可する場合、PUTバケットポリシーへの呼び出しを拒否する"
  type        = bool
  default     = true
}

variable ignore_public_acls {
  description = "バケットのパブリックACLを無視するかどうかを示すブール値。デフォルト値は`true`。trueの場合、\nこのアカウントのバケットとそれらに含まれるオブジェクトのすべてのパブリックACLを無視する"
  type        = bool
  default     = true
}

variable restrict_public_buckets {
  description = "バケットのパブリックバケットポリシーを制限するかどうかを示すブール値。デフォルト値は`true`。trueの場合、\nパブリックポリシーでバケットにアクセスできるのは、バケット所有者とAWSサービスのみ"
  type        = bool
  default     = true
}

# --------------------------------------------------------------------------------
# aws_s3_bucket_policy resource variables
# --------------------------------------------------------------------------------

variable create_s3_bucket_policy {
  description = "S3のバケットポリシーリソースを作成する（true）、しない（false）を示すブール値。デフォルト値は`false`"
  type        = bool
  default     = false
}
