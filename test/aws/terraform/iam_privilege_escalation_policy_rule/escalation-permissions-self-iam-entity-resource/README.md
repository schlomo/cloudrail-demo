Privilege escalation is a real concern in almost every environment, including AWS.
A situation where a hacker gains unauthorized access to a specific IAM entity (such as a role)
and uses that to get higher level permissions is a tough one to spot.

Cloudrail uses a set of logic to analyze the policies assigned to IAM entities (users, groups and roles)
and determine if there's a possibility for privilege escalation.

In the example here, we see a group which is allows to do any `iam:Create*` function, but only on itself.

```hcl
resource "aws_iam_group_policy" "allow-policy" {
  name = "allow-policy"
  group = aws_iam_group.group-1.name

  policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": [
          "iam:Create*"
        ],
        "Effect": "Allow",
        "Resource": "arn:aws:iam::111111111111:group/${aws_iam_group.group-1.name}"
      }
    ]
  }
  EOF

  depends_on = [aws_iam_group.group-1]
}
```

Cloudrail understands this, and knows that it doesn't need to flag this. The `iam:create*` actions, when
limiting only to this group, will not open the ability for privilege escalation. 