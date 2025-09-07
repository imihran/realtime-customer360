locals {
  bucket_prefix = "c360-raw"
}

# short random suffix so name is unique across AWS
resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}

resource "aws_s3_bucket" "raw" {
  bucket = lower("${local.bucket_prefix}-${var.owner}-${random_string.suffix.result}")

  tags = {
    Project = "realtime-customer360"
    Owner   = var.owner
    Env     = "dev"
  }
}

# Enable object versioning (safety net for deletes/overwrites)
resource "aws_s3_bucket_versioning" "raw" {
  bucket = aws_s3_bucket.raw.id
  versioning_configuration { status = "Enabled" }
}

# Default server-side encryption (SSE-S3). We'll upgrade to KMS in hardening.
resource "aws_s3_bucket_server_side_encryption_configuration" "raw" {
  bucket = aws_s3_bucket.raw.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
