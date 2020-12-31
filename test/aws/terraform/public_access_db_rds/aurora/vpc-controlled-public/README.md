Determining whether a database, or any resource, is accessible to the Internet is more than just
looking at a flag (like "publicly_accessible = true"). One must also check to see
if there's routing that exposes the resource, and whether the security group and NACL is 
exposing the specific ports the resource uses.

This kind of context analysis is unique to Cloudrail, and can be seen in the output:

```
Rule: Ensure RDS database is not publicly accessible
 - 1 Resources Exposed:
-----------------------------------------------
   - Exposed Resource: [aws_rds_cluster.test] (main.tf:63)
     Violating Resource: [aws_security_group.nondefault]  (main.tf:12)

     Evidence:
         Internet
             | Instance aws_rds_cluster_instance.ins1 is in RDS cluster aws_rds_cluster.test
             | Instance is on VPC aws_vpc.nondefault
             | Instance uses subnet(s) aws_security_group.nondefault
             | Instance is reachable from the internet due to subnet(s) and route table(s)
             | Subnet uses NACL(s) nacl-pseudo-5991ec62-7829-479d-92fa-700bc1a6ae00, nacl-pseudo-5991ec62-7829-479d-92fa-700bc1a6ae00
             | NACL(s) and Security Group(s) allows the RDS configured ports
         RDS Instance
```