provider "aws" {
  region = "us-east-1"
}

# Random suffix to keep bucket names unique (even though we won't apply)
resource "random_id" "rand" {
  byte_length = 4
}

locals {
  bucket_name = "sp360-artifacts-example-${random_id.rand.hex}"
}

# Private S3 bucket for artifacts (example only; we won't apply)
resource "aws_s3_bucket" "secure_pipeline_artifacts" {
  bucket        = local.bucket_name
  force_destroy = false

  tags = {
    Project = "SecurePipeline360"
  }
}

# Enforce bucket-owner ownership (avoids ACL issues)
resource "aws_s3_bucket_ownership_controls" "owner" {
  bucket = aws_s3_bucket.secure_pipeline_artifacts.id
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

# Block all forms of public access
resource "aws_s3_bucket_public_access_block" "block_public" {
  bucket                  = aws_s3_bucket.secure_pipeline_artifacts.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Default server-side encryption (SSE-S3)
resource "aws_s3_bucket_server_side_encryption_configuration" "sse" {
  bucket = aws_s3_bucket.secure_pipeline_artifacts.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Enable versioning (required by many policies)
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.secure_pipeline_artifacts.id
  versioning_configuration {
    status = "Enabled"
  }
}
