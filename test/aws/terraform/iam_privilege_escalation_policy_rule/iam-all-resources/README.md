Privilege escalation is a real concern in almost every environment, including AWS.
A situation where a hacker gains unauthorized access to a specific IAM entity (such as a role)
and uses that to get higher level permissions is a tough one to spot.

Cloudrail uses a set of logic to analyze the policies assigned to IAM entities (users, groups and roles)
and determine if there's a possibility for privilege escalation.

In the example here, we see an easy case of a role with high IAM permissions,
allowing it to create an entity it wants and give it whatever permissions it wants.


```hcl
resource "aws_iam_role_policy" "policy" {
  name = "policy"
  role = aws_iam_role.role.id

  policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": [
          "iam:*", "iam: AttachUser*"
        ],
        "Effect": "Allow",
        "Resource": "*"
      },
      {
        "Action": [
          "s3:*"
        ],
        "Effect": "Allow",
        "Resource": "*"
      }
    ]
  }
  EOF
}
```

Cloudrail understands this, and flags it:

```
Rule: Disallow IAM permissions which can lead to privilege escalation
 - 1 Resources Exposed:
-----------------------------------------------
   - Exposed Resource: [test_for_cloudrail-demo-repo] (Not found in TF)
     Violating Resource: [aws_iam_role_policy.policy]  (main.tf:25)

     Evidence:
         aws_iam_role_policy.policy
             | is applied to aws_iam_role.role.arn
             |  granting the problematic permissions {'iam:*', 'iam: AttachUser*'} which can allow for privilege escalation

```