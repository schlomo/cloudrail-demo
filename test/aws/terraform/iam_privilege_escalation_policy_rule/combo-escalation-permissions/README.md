Privilege escalation is a real concern in almost every environment, including AWS.
A situation where a hacker gains unauthorized access to a specific IAM entity (such as a role)
and uses that to get higher level permissions is a tough one to spot.

Cloudrail uses a set of logic to analyze the policies assigned to IAM entities (users, groups and roles)
and determine if there's a possibility for privilege escalation.

In the example here, we see a role is allowed to create a Lambda function and invoke it.
This role is also allowed to pass a role to a Lambda function of their choosing.


```hcl
resource "aws_iam_role_policy" "allow-policy-1" {
  name = "allow-policy-1"
  role = aws_iam_role.role.id

  policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": [
          "iam:PassRole"
        ],
        "Effect": "Allow",
        "Resource": "*"
      }
    ]
  }
  EOF
}

resource "aws_iam_role_policy" "allow-policy-2" {
  name = "allow-policy-2"
  role = aws_iam_role.role.id

  policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": [
          "lambda:CreateFunction", "lambda:Invokefunc*"
        ],
        "Effect": "Allow",
        "Resource": "*"
      }
    ]
  }
  EOF
}
```

If you take these two sets of permissions together, you realize the role is capable of 
spinning up a function and giving it any role they want, including ones with administrator
privileges. Since they also control the code within the function and the ability to invoke
it, this role can be used as an entry path by a hacker to achieve their goals.

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