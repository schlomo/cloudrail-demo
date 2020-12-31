This scenario shows a CloudFront distribution that is using a secure protocol. Notice that it also has an S3 bucket that is public:

```hcl
resource "aws_s3_bucket" "dist" {
  bucket = "dist-cloud-test"
  acl    = "public-read-write"

  tags = {
    Name = "dist-cloud-test"
  }
  logging {
   	target_bucket = aws_s3_bucket.logging.id
  	target_prefix = "log/"
  }
}
```

The question of whether this bucket's ACL is a problem depends on other parameters, such as the account-level Public Access Block. 

Most accounts do have this block enabled.

If the target account does have the public access block enabled, Cloudrail will not flag a vioation here.
However, if it does not, Cloudrail will flag a violation. This is an example of Cloudrail's ability to take the account's settings into account
when evaluating a Terraform plan.