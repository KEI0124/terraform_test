resource "aws_s3_bucket" "this" {
  bucket              = var.bucket
  acl                 = var.acl
  region = var.region
  force_destroy       = var.force_destroy
  acceleration_status = var.acceleration_status
  request_payer       = var.request_payer

  versioning {
    enabled    = var.versioning_enabled
    mfa_delete = var.versioning_mfa_delete
  }

  dynamic "logging" {
    for_each = var.logging
    content {
      target_bucket = logging.value.target_bucket
      target_prefix = logging.value.target_prefix
    }
  }

  dynamic "server_side_encryption_configuration" {
    for_each = var.server_side_encryption_configuration
    content {

      dynamic "rule" {
        for_each = server_side_encryption_configuration.value.rule
        content {

          dynamic "apply_server_side_encryption_by_default" {
            for_each = rule.value.apply_server_side_encryption_by_default
            content {
              sse_algorithm     = apply_server_side_encryption_by_default.value.sse_algorithm
              kms_master_key_id = lookup(apply_server_side_encryption_by_default.value, "kms_master_key_id", null)
            }
          }
        }
      }
    }
  }

  dynamic "lifecycle_rule" {
    for_each = var.lifecycle_rule
    content {
      id                                     = lookup(lifecycle_rule.value, "id", null)
      prefix                                 = lookup(lifecycle_rule.value, "prefix", null)
      tags                                   = lookup(lifecycle_rule.value, "tags", null)
      enabled                                = lookup(lifecycle_rule.value, "enabled", null)
      abort_incomplete_multipart_upload_days = lookup(lifecycle_rule.value, "abort_incomplete_multipart_upload_days", null)

      dynamic "transition" {
        for_each = lookup(lifecycle_rule.value, "transition", [])
        content {
          date          = lookup(transition.value, "date", null)
          days          = lookup(transition.value, "days", null)
          storage_class = transition.value.storage_class
        }
      }

      dynamic "noncurrent_version_transition" {
        for_each = lookup(lifecycle_rule.value, "noncurrent_version_transition", [])
        content {
          days          = lookup(noncurrent_version_transition.value, "days", null)
          storage_class = noncurrent_version_transition.value.storage_class
        }
      }

      dynamic "noncurrent_version_expiration" {
        for_each = lookup(lifecycle_rule.value, "noncurrent_version_expiration", [])
        content {
          days = lookup(noncurrent_version_expiration.value, "days", null)
        }
      }

      dynamic "expiration" {
        for_each = lookup(lifecycle_rule.value, "expiration", [])
        content {
          date                         = lookup(expiration.value, "date", null)
          days                         = lookup(expiration.value, "days", null)
          expired_object_delete_marker = lookup(expiration.value, "expired_object_delete_marker", null)
        }
      }
    }
  }

  tags = merge(var.tags, { "Name" = var.bucket })
}

# --------------------------------------------------------------------------------
# aws_s3_bucket_public_access_block resource definition
# @see https://www.terraform.io/docs/providers/aws/r/s3_account_public_access_block.html
# --------------------------------------------------------------------------------

resource "aws_s3_bucket_public_access_block" "this" {
  bucket                  = aws_s3_bucket.this.id
  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets
  depends_on              = [aws_s3_bucket.this]
}

# --------------------------------------------------------------------------------
# aws_s3_bucket_policy resource definition
# @see https://www.terraform.io/docs/providers/aws/r/s3_bucket_policy.html
# --------------------------------------------------------------------------------

resource "aws_s3_bucket_policy" "this" {
  count  = var.create_s3_bucket_policy ? 1 : 0
  bucket = aws_s3_bucket.this.id
  policy = templatefile("${path.module}/template/s3_bucket_policy.json.tpl", {resource = aws_s3_bucket.this.arn, account=data.aws_elb_service_account.this.id})

  depends_on = [
    aws_s3_bucket.this,
    aws_s3_bucket_public_access_block.this,
  ]
}