Determining whether a database, or any resource, is accessible to the Internet is more than just
looking at a flag (like "publicly_accessible = true"). One must also check to see
if there's routing that exposes the resource, and whether the security group and NACL is 
exposing the specific ports the resource uses.

This kind of context analysis is unique to Cloudrail. Notice that Cloudrail is the only tool not
alerting about this database being exposed publicly. The reason for that is that Cloudrail
can see the database cannot route to the Internet, and therefore isn't truly exposed publicly.

If it would have had routing to the Internet, the message would look like this:

```
Rule: Ensure Redshift database is not publicly accessible
 - 1 Resources Exposed:
-----------------------------------------------
   - Exposed Resource: [aws_redshift_cluster.test] (main.tf:97)
     Violating Resource: [aws_security_group.nondefault]  (main.tf:11)

     Evidence:
         Internet
             | Redshift DB: aws_redshift_cluster.test
             | is on VPC aws_vpc.nondefault
             | Redshift cluster uses Security-Groups aws_security_group.nondefault
             | Security Group(s) allow Redshift associated portCluster is on subnets: aws_subnet.nondefault_1, aws_subnet.nondefault_2
             | Subnets rely on NACL(s) aws_network_acl.public, aws_network_acl.private
             | Redshift is capable of traversing to the internet via Redshift associated port
         Redshift aws_redshift_cluster.test
```