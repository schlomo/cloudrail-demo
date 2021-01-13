This scenario shows a CloudFront distribution that is using an insecure protocol. Notice that it also has an S3 bucket that is public:

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

Most accounts do have this block enabled, even if it's not clear in the Terraform code itself (beause it was enabled elsewhere).

If the target account _does_ have the public access block enabled, as is the case in this example, Cloudrail will not flag a violation here.
However, if it does not, Cloudrail will flag a violation. This is an example of Cloudrail's ability to take the account's settings into account
when evaluating a Terraform plan.