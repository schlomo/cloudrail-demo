Privilege escalation is a real concern in almost every environment, including AWS.
A situation where a hacker gains unauthorized access to a specific IAM entity (such as a role)
and uses that to get higher level permissions is a tough one to spot.

Cloudrail uses a set of logic to analyze the policies assigned to IAM entities (users, groups and roles)
and determine if there's a possibility for privilege escalation.

In the example here, we see a role is allowed to create access keys for any IAM user 
they want. This, in turn, allows a hacker to create an access key for a user with 
more privileges and gain access to resources they couldn't before.

```hcl
resource "aws_iam_user_policy" "allow-policy" {
  name = "allow-policy"
  user = aws_iam_user.user-1.name

  policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": [
          "iam:CreateAccessKey"
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
     Violating Resource: [aws_iam_role_policy.allow-policy-1]  (main.tf:25)

     Evidence:
         aws_iam_role_policy.allow-policy-1
             | is applied to aws_iam_role.role.arn
             | in conjunction with aws_iam_role_policy.allow-policy-1, aws_iam_role_policy.allow-policy-2 {'lambda: createfunction', 'iam: passrole', 'lambda: invokefunc*'} allows a hacker to trigger a Lambda function with a role they choose
```