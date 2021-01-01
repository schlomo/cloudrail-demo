In its analysis, Cloudrail will take into account the AWS account's parameters.

For example, those accounts created before 2013-12-04 supported "Classic Mode". Cloudrail will read the account attributes to determine if it's supported by your acount.

If it is supported, and a resource you are attempting to create is about to utilize Classic Mode, you'll get a notification.

For example, this resource, in an account created in 2012:
```hcl
resource "aws_redshift_cluster" "test" {
  cluster_identifier = "redshift-defaults-only"
  node_type = "dc2.large"
  master_password = "Test1234"
  master_username = "test"
  skip_final_snapshot = true
}

```

Will produce this violation:
```
Rule: Ensure EC2-Classic mode is not used
 - 1 Resources Exposed:
-----------------------------------------------
   - Exposed Resource: [aws_redshift_cluster.test] (main.tf:5)
     Violating Resource: [aws_redshift_cluster.test] (main.tf:5)

     Evidence:
         Redshift Cluster
             | Redshift cluster with database name test is using EC2-Classic mode
             | It should use EC2-VPC mode instead

```