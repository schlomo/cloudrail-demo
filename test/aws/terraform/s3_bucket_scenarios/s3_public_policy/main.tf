# Public - Shouldn't pass the test
# -----------------------------------
resource "aws_s3_bucket" "bucket_1" {
  bucket = "bucket-with-public-policy-1"
}

resource "aws_s3_bucket_policy" "bucket_1_policy" {
  bucket = aws_s3_bucket.bucket_1.id

  policy = <<POLICY
{
  "Version":"2012-10-17",
  "Statement":[
    {
      "Sid":"PublicRead",
      "Effect":"Allow",
      "Principal": "*",
      "Action":["s3:GetObject","s3:GetObjectVersion"],
      "Resource":["arn:aws:s3:::bucket-with-public-policy-1/*"]
    }
  ]
}
POLICY
}
# -----------------------------------

# Public - Shouldn't pass the test
# -----------------------------------
resource "aws_s3_bucket" "bucket_2" {
  bucket = "bucket-with-public-policy-2"
}

resource "aws_s3_bucket_policy" "bucket_2_policy" {
  bucket = aws_s3_bucket.bucket_2.id

  policy = <<POLICY
{
  "Version":"2012-10-17",
  "Statement":[
    {
      "Sid":"PublicRead",
      "Effect":"Allow",
      "Principal": {"AWS": "*"},
      "Action":["s3:GetObject","s3:GetObjectVersion"],
      "Resource":["arn:aws:s3:::bucket-with-public-policy-2/*"]
    }
  ]
}
POLICY
}
# -----------------------------------

# Not public - Should pass the test
# -----------------------------------
resource "aws_s3_bucket" "bucket_3" {
  bucket = "bucket-with-public-policy-3"
}

resource "aws_s3_bucket_policy" "bucket_3_policy" {
  bucket = aws_s3_bucket.bucket_3.id

  policy = <<POLICY
{
  "Version":"2012-10-17",
  "Statement":[
    {
      "Sid":"PublicRead",
      "Effect":"Allow",
      "Principal": "*",
      "Action":["s3:GetObject","s3:GetObjectVersion"],
      "Resource":["arn:aws:s3:::bucket-with-public-policy-3/*"]
    }
  ]
}
POLICY
}

resource "aws_s3_bucket_public_access_block" "block_public_bucket_3" {
  bucket = aws_s3_bucket.bucket_3.id
  block_public_acls = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true
  depends_on = [aws_s3_bucket_policy.bucket_3_policy]
}
# -----------------------------------