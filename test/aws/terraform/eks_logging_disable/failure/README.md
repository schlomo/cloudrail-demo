While this is a simple example, note something interesting:

Competing tools are alerting that the EKS API is accessible to 0.0.0.0. However, Cloudrail is not. The reason is that Cloudrail is able to determine that the subnet in use, does not have routing to the Internet:

```hcl
resource "aws_subnet" "subnet1" {
  cidr_block = "10.0.0.0/24"
  vpc_id = aws_vpc.vpc.id
}
```

Is in a VPC:
```hcl
resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
}
```

Which doesn't have an Internet Gateway.