Privilege escalation is a real concern in almost every environment, including AWS.
A situation where a hacker gains unauthorized access to a specific IAM entity (such as a role)
and uses that to get higher level permissions is a tough one to spot.

Cloudrail uses a set of logic to analyze the policies assigned to IAM entities (users, groups and roles)
and determine if there's a possibility for privilege escalation.

In the example here, we see a problematic policy, however it's not attached to anything.

```hcl
resource "aws_iam_policy" "allow-policy" {
  name = "allow-policy"
  description = "un-attached policy"

  policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": [
          "iam:*"
        ],
        "Effect": "Allow",
        "Resource": "*"
      }
    ]
  }
  EOF

}
```

And so, Cloudrail knows to ignore it. This is important - Cloudrail runs within the CI
pipeline and focuses on catching only issues that justify stopping the pipeline.

If this policy will be used in the future, Cloudrail will catch it and stop the pipeline to
have the developer fix it.