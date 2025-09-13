provider "aws" {
  region = "us-east-1"
}

resource "random_id" "rand" {
  byte_length = 4
}

# Example only (we won't apply) — configured to be private and block public access
resource "aws_s3_bucket" "secure_pipeline_artifacts" {
  bucket        = "sp360-artifacts-example-"
  force_destroy = false
}

resource "aws_s3_bucket_public_access_block" "block_public" {
  bucket                  = aws_s3_bucket.secure_pipeline_artifacts.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
