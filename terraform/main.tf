provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "example" {
  bucket = "securepipeline360-demo"
  acl    = "private"
}
