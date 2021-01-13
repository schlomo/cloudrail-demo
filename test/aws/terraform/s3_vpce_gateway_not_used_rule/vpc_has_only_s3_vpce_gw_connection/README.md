Here we have an S3 bucket and a VPC endpoint for the S3 service. Routing is configured correctly.

However, the S3 bucket's policy is not limiting incoming traffic to be from the source VPC where the VPC endpoint is routed to.

It's important to use the `sourcevpc` condition. This will help secure the S3 bucket in case someone steals the credentials of a compute resource who can access the S3 bucket.

To highlight the issue, Cloudrail shows this violation:
```
-----------------------------------------------
Rule: Ensure that the private bucket's policy reference a VPC Endpoint as source
 - 1 Resources Exposed:
-----------------------------------------------
   - Exposed Resource: [aws_s3_bucket.public-bucket] (main.tf:101)
     Violating Resource: [aws_s3_bucket.public-bucket]  (main.tf:101)

     Evidence:
             | ~Bucket aws_s3_bucket.public-bucket
             | is accessible via VPC endpoint vpce-0d03e8972ac4910df
             | in VPC sfdc-somestage-consoleme
             | with a policy that is not restricting requests sourced from a VPC Endpoint.

```