# Too Permissive when AWS account number is not the bucket owner account
# -----------------------------------
provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "public-bucket" {
  bucket = "bucket-with-over-privileged-policy-1"
}

resource "aws_s3_bucket_public_access_block" "block_public_bucket_3" {
  bucket = aws_s3_bucket.public-bucket.id
  block_public_acls = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "bucket_1_policy" {
  bucket = aws_s3_bucket.public-bucket.id

  // This has a made up remote account number
  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AllActionsOnS3",
            "Effect": "Allow",
            "Principal": {
                "AWS": "123456789012"
            },
            "Action": "s3:*",
            "Resource": [
                "arn:aws:s3:::bucket-with-over-privileged-policy-1",
                "arn:aws:s3:::bucket-with-over-privileged-policy-1/*"
            ]
        }
    ]
}
POLICY
}