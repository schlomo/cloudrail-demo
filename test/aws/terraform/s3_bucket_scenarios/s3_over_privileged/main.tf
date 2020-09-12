# Too Permissive when AWS account number is not the bucket owner account
# -----------------------------------
resource "aws_s3_bucket" "bucket_1" {
  bucket = "bucket-with-over-privileged-policy-1"
}

resource "aws_s3_bucket_policy" "bucket_1_policy" {
  bucket = aws_s3_bucket.bucket_1.id

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AllActionsOnS3",
            "Effect": "Allow",
            "Principal": {
                "AWS": "###REMOTE-ACCOUNT-NUMBER###"
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
# -----------------------------------

# Not too permissive because of Conditions
# -----------------------------------
resource "aws_s3_bucket" "bucket_2" {
  bucket = "bucket-with-over-privileged-policy-2"
}

resource "aws_s3_bucket_policy" "bucket_2_policy" {
  bucket = aws_s3_bucket.bucket_2.id

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AllowAllActionsOnS3ForUser",
            "Effect": "Allow",
            "Principal": {
                "AWS": "###REMOTE-ACCOUNT-NUMBER###"
            },
            "Action": "s3:*",
            "Resource": [
                "arn:aws:s3:::bucket-with-over-privileged-policy-2",
                "arn:aws:s3:::bucket-with-over-privileged-policy-2/*"
            ],
            "Condition": { "StringEqualsIgnoreCase": { "aws:username": "###REMOTE-USER-NAME###"}}
        }
    ]
}
POLICY
}
# -----------------------------------