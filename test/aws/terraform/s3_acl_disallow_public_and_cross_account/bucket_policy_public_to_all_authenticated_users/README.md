In this case, a canned ACL is not used, but the bucket policy is widely open:

```json
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
```

And so, Cloudrail alerts:
```
Rule: Ensure S3 buckets are not made widely accessible through ACLs and bucket policies
 - 1 Resources Exposed:
-----------------------------------------------
   - Exposed Resource: [aws_s3_bucket.public-bucket] (main.tf:5)
     Violating Resource: [aws_s3_bucket_policy.bucket_2_policy]  (main.tf:9)

     Evidence:
             | The S3 bucket aws_s3_bucket.public-bucket is publicly exposed through the S3 Policy with identifier aws_s3_bucket_policy.bucket_2_policy
```