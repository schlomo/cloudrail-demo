This is a curious test. At first look, it's obvious - the bucket is publicly accessible:

```hcl
resource "aws_s3_bucket" "public-bucket" {
  bucket = "bucket-with-public-acl-2"
  acl = "authenticated-read"
}
```

However, what you can't see, is the account-level block settings.

If you run this plan against an account that doesn't have public-block set at the account level, Cloudrail will find a violation.

However, if your account DOES have public-access block enabled, it won't find anything.

The reason: Cloudrail takes into consideration the account-level access block, even if it's not specified in the Terraform plan.