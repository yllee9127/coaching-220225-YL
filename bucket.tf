resource "aws_s3_bucket" "yap-s3-bucket" {
  bucket = "yap-bucket-220225"
}

resource "aws_s3_bucket_ownership_controls" "yap-s3-controls" {
  bucket = aws_s3_bucket.yap-s3-bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "yap-s3-public-access" {
  bucket = aws_s3_bucket.yap-s3-bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "yap-s3-acl" {
  depends_on = [
    aws_s3_bucket_ownership_controls.yap-s3-controls,
    aws_s3_bucket_public_access_block.yap-s3-public-access,
  ]

  bucket = aws_s3_bucket.yap-s3-bucket.id
  acl    = "public-read"
}