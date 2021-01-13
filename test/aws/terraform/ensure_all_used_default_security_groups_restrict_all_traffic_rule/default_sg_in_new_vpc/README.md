Cloudrail is capable of being aware of objects that are not referenced at all in the Terraform plan.

In this case, we have a resource that will be using the default security group, simply because it did not provide a specific one:

```hcl
resource "aws_instance" "ec2" {
  ami           = "ami-07cda0db070313c52"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.subnet.id

  tags = {
    Name = local.test_name
  }
}
```

Cloudrail sees this, and pulls the data pertaining to the default security group in the specific VPC (based on the subnet). 
If that security group is overly permissive, a violation is highlighted:

```
Rule: Ensure all used default security groups of every VPC restrict all traffic
 - 1 Resources Exposed:
-----------------------------------------------
   - Exposed Resource: [aws_instance.ec2] (main.tf:31)
     Violating Resource: [sg-pseudo-8790f8d8-d1fe-4f33-9cba-bc58a590becd]  (Not found in TF)

     Evidence:
         VPC aws_vpc.vpc
             | eni-pseudo-41ef189d-0d3e-44c4-b68d-c46c26c59e37 uses ENI aws_instance.ec2
             | The ENI is secured by default Security Group sg-pseudo-8790f8d8-d1fe-4f33-9cba-bc58a590becd and allow all traffic


```