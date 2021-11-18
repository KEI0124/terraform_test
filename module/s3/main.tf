module "s3_log" {
  source             = "../../resource/s3"
  bucket             = "s3b-alb-accesslog-cvsi"
  acl                = "private"
  force_destroy      = true
  versioning_enabled = true
  region             = data.aws_region.current.name
  server_side_encryption_configuration = [
    {
      rule = [
        {
          apply_server_side_encryption_by_default = [
            {
              sse_algorithm = "AES256"
            }
          ]
        }
      ]
    }
  ]
  logging = []
  lifecycle_rule = [
    {
      id      = "cloudwatchlogs"
      prefix  = "cloudwatchlogs/"
      enabled = true
      transition = [
        {
          days          = 30
          storage_class = "STANDARD_IA"
        },
        {
          days          = 90
          storage_class = "GLACIER"
        }
      ]
      noncurrent_version_transition = [
        {
          days          = 30
          storage_class = "STANDARD_IA"
        },
        {
          days          = 90
          storage_class = "GLACIER"
        }
      ]
      noncurrent_version_expiration = [
        {
          days = 1095
        }
      ]
      expiration = [
        {
          days = 1095
        }
      ]
    },
    {
      id      = "elb"
      prefix  = "elb/"
      enabled = true
      transition = [
        {
          days          = 30
          storage_class = "STANDARD_IA"
        },
        {
          days          = 90
          storage_class = "GLACIER"
        }
      ]
      noncurrent_version_transition = [
        {
          days          = 30
          storage_class = "STANDARD_IA"
        },
        {
          days          = 90
          storage_class = "GLACIER"
        }
      ]
      noncurrent_version_expiration = [
        {
          days = 1095
        }
      ]
      expiration = [
        {
          days = 1095
        }
      ]
    },
    {
      id      = "cloudtrail"
      prefix  = "cloudtrail/"
      enabled = true
      transition = [
        {
          days          = 30
          storage_class = "STANDARD_IA"
        },
        {
          days          = 90
          storage_class = "GLACIER"
        }
      ]
      noncurrent_version_transition = [
        {
          days          = 30
          storage_class = "STANDARD_IA"
        },
        {
          days          = 90
          storage_class = "GLACIER"
        }
      ]
      noncurrent_version_expiration = [
        {
          days = 1095
        }
      ]
      expiration = [
        {
          days = 1095
        }
      ]
    }
  ]
  create_s3_bucket_policy = true
  tags                    = var.tags
}
