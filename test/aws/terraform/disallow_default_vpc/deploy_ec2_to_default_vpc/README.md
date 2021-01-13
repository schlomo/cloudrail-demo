Using the default VPC is generally a bad idea. Users should define specific VPCs and place every resource in a VPC that matches
its needs.

Cloudrail is capable of determining whether a resource is expected to be placed in a default VPC. 
Cloudrail is also aware if a default VPC even exists or not (in the AWS account itself).

For example, in this case, this resource is specifically placing itself in the default VPC:
```hcl
resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

resource "aws_subnet" "default-subnet" {
  vpc_id     = aws_default_vpc.default.id
  cidr_block = "192.168.10.0/24"
  availability_zone = local.region
}

resource "aws_instance" "t2-instance" {
  ami = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id = aws_subnet.default-subnet.id
}
```

If there is a default VPC, and a resource is expected to be placed there, a violation will be highlighted:
```
-----------------------------------------------
Rule: Ensure the default VPC is not used
 - 1 Resources Exposed:
-----------------------------------------------
   - Exposed Resource: [aws_instance.t2-instance] (main.tf:49)
     Violating Resource: [aws_instance.t2-instance]  (main.tf:49)

     Evidence:
         Default VPC
             | aws_instance.t2-instance is defined within the default VPC.

```

If there is no default VPC, Cloudrail will provide a clear error message:
```
Could not find an existing default VPC that is described by main.tf. 
```