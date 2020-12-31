Here we have a somewhat complicated example.

There's a bastion server, situated on a public subnet, that was created through the 
VPC module under the "complete VPC" example.

This means, that we've also created a DynamoDB VPC endpoint, but have not associated it with 
the public subnet (the module doesn't associate the VPC endpoints with the public subnets by default).

So, Cloudrail found a couple of issues:

1. The DyanmoDB VPC endpoint is in use, but is not accessible to the one resource that _may_ need it
(the bastion server):
```
Rule: Ensure VPC Endpoint for DYNAMODB is enabled in all route tables in use in a VPC
 - 1 Resources Exposed:
-----------------------------------------------
   - Exposed Resource: [module.vpc_example_complete-vpc.module.vpc.aws_vpc.this[0]] (.terraform/modules/vpc_example_complete-vpc/main.tf:29)
     Violating Resource: [module.vpc_example_complete-vpc.module.vpc.aws_route_table.private[0]]  (.terraform/modules/vpc_example_complete-vpc/main.tf:204)

     Evidence:
             | The VPC ~module.vpc_example_complete-vpc.module.vpc.aws_vpc.this[0]~ has a DYNAMODB Endpoint Gateway, but ~module.vpc_example_complete-vpc.module.vpc.aws_subnet.database[0]~ uses ~module.vpc_example_complete-vpc.module.vpc.aws_route_table.private[0]~, which does not have a route to the endpoint gateway
```

2. The bastion host is exposed on port 22 (of course):
```
Rule: Ensure no used security groups allow ingress from 0.0.0.0/0 or ::/0 to port 22 (SSH)
 - 1 Resources Exposed:
-----------------------------------------------
   - Exposed Resource: [module.ec2-bastion-server.aws_instance.default[0]] (.terraform/modules/ec2-bastion-server/main.tf:87)
     Violating Resource: [module.ec2-bastion-server.aws_security_group.default[0]]  (.terraform/modules/ec2-bastion-server/main.tf:42)

     Evidence:
         Internet
             | Subnet module.vpc_example_complete-vpc.module.vpc.aws_subnet.public[0] has Internet Gateway
             | Instance module.ec2-bastion-server.aws_instance.default[0] is on module.vpc_example_complete-vpc.module.vpc.aws_subnet.public[0]
             | Subnet routes traffic from instance to Internet Gateway
             | Subnet uses NACL nacl-pseudo-11c60635-0451-44af-80e1-a6ce8604be39 which allows port 22
             | Instance uses Security Group ['module.ec2-bastion-server.aws_security_group.default[0]']
             | Security Group allows port 22
         Instance
```