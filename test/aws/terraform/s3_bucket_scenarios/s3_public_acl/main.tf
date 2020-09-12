# Public - Shouldn't pass the test
# -----------------------------------
resource "aws_s3_bucket" "bucket_1" {
  bucket = "bucket-with-public-acl-1"
  acl = "public-read"
}
# -----------------------------------

# Public - Shouldn't pass the test
# -----------------------------------
resource "aws_s3_bucket" "bucket_2" {
  bucket = "bucket-with-public-acl-2"
  acl = "public-read-write"
}
# -----------------------------------

# Not public - Should pass the test
# -----------------------------------
resource "aws_s3_bucket" "bucket_3" {
  bucket = "bucket-with-public-acl-3"
  acl = "public-read-write"
}

resource "aws_s3_bucket_public_access_block" "block_public_bucket_3" {
  bucket = aws_s3_bucket.bucket_3.id
  block_public_acls = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true
}
# -----------------------------------