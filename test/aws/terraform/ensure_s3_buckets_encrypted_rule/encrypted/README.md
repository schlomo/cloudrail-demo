Best practices for securing S3 buckets include:
* Encrypting the bucket
* Using a VPC endpoint
* Making the bucket private

However, there's one step further you should take. Limit the traffic coming into the bucket to the VPC endpoints you've defined.

Cloudrail's context engine is capable of determining that the S3 bucket policy is not limiting incoming traffic to specific VPC endpoints,
and will tell you about it. It can even do this if there's no S3 bucket policy defined at all.

What's more, the engine is smart enough to only do this analysis on buckets that are considered private. This reduces the noise
that may be generated for public buckets (which are public on purpose).

In the example here, we ran Cloudrail with the included main.tf, against an account that already had a VPC with a VPC endpoint in it (not visibile via the main.tf or Terraform plan).

And this is how the violation looks like:

```
Rule: Ensure that the private bucket's policy reference a VPC Endpoint as source
 - 2 Resources Exposed:
-----------------------------------------------
   - Exposed Resource: [aws_s3_bucket.kms-s3-encrypted] (main.tf:27)
     Violating Resource: [aws_s3_bucket.kms-s3-encrypted]  (main.tf:27)

     Evidence:
             | ~Bucket aws_s3_bucket.kms-s3-encrypted
             | is accessible via VPC endpoint vpce-0d03e8972ac4910df
             | in VPC sfdc-somestage-consoleme
             | with a policy that is not restricting requests sourced from a VPC Endpoint.
```