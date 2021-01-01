Here we have a case where Cloudrail can distinguish between different types of KMS keys, and use that in its analysis.

Our Code Build Project:
```hcl
resource "aws_codebuild_project" "project-cloudrail-test" {
  name           = "project-cloudrail-test"
  description    = "project-cloudrail-test"
  encryption_key = data.aws_kms_key.by_alias.arn

  ...
}

```

Is referencing an existing key provided by AWS:
```hcl
data "aws_kms_key" "by_alias" {
  key_id = "alias/aws/s3"
}
```

Which Cloudrail is aware of (as it scans the live AWS environment), and knows it's an AWS managed key. Therefore, a violation is identified:
```
Rule: Ensure CodeBuild projects are set to be encrypted at rest with customer-managed CMK
 - 1 Resources Exposed:
-----------------------------------------------
   - Exposed Resource: [aws_codebuild_project.project-cloudrail-test] (main.tf:29)
     Violating Resource: [aws_codebuild_project.project-cloudrail-test]  (main.tf:29)

     Evidence:
             | The CodeBuild project aws_codebuild_project.project-cloudrail-test is not set to use encryption at rest with customer-managed CMK

```