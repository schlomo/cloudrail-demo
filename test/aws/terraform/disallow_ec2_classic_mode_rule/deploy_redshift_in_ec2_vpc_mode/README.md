In this case, Cloudrail's ability to emulate an AWS account's behavior allows it find issues others would not.

When a VPC is created, a default security group is automatically created. For example, for this VPC in the code:

```hcl
resource "aws_vpc" "nondefault" {
  cidr_block = "10.1.1.0/24"
}
```

A default security group will be created. However, it's not specified in the Terraform code, and so is ignored by other tools.

Cloudrail, however, is aware of this. But that's not all, as Cloudrail will not flag a security group that is not in use. Cloudrail has been able to determine that the database in the code is using the default security group:

```hcl
resource "aws_redshift_cluster" "test" {
  cluster_identifier = "redshift-defaults-only"
  node_type = "dc2.large"
  master_password = "Test1234"
  master_username = "test"
  skip_final_snapshot = true
  cluster_subnet_group_name = aws_redshift_subnet_group.nondefault.name
  publicly_accessible = false
}
```

And so, Cloudrail found a default security group that is not explicit in the code, and found that it's used, and so, flagged it:

```
Rule: Ensure all used default security groups of every VPC restrict all traffic
 - 1 Resources Exposed:
-----------------------------------------------
   - Exposed Resource: [aws_redshift_cluster.test] (main.tf:28)
     Violating Resource: [sg-pseudo-785a087b-facb-4f3b-9683-fd2f3b43b7f5]  (Not found in TF)

     Evidence:
         VPC aws_vpc.nondefault
             | eni-pseudo-586903af-1dd1-4373-91e0-fe58bfec9052 uses ENI aws_redshift_cluster.test
             | The ENI is secured by default Security Group sg-pseudo-785a087b-facb-4f3b-9683-fd2f3b43b7f5 and allow all traffic

Cloudrail has listed "pseudo" objects in the above results.
These are resources that don't exist yet, or don't show in the Terraform input, but we know will be created in the real live environment.
```