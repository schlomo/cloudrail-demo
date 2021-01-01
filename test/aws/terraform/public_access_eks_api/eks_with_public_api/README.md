When attempting to determine if a resource is publicly accessible, Cloudrail takes into account multiple layers. These include the routing table,
access to an Internet Gateway, the use of public IP addresses, NACLs, and Security Groups (if applicable) and more.

In this example here, notice the evidence in the violation, explaining how Cloudrail came to its conclusion:

```
Rule: Ensure EKS API is not publicly accessible
 - 1 Resources Exposed:
-----------------------------------------------
   - Exposed Resource: [module.my-cluster.aws_eks_cluster.this[0]] (.terraform/modules/my-cluster/cluster.tf:9)
     Violating Resource: [aws_security_group.cluster]  (main.tf:35)

     Evidence:
         Internet
             | Eks Cluster module.my-cluster.aws_eks_cluster.this[0] is on VPC module.vpc.aws_vpc.this[0]
             | Master is protected by Security-Groups sg-pseudo-176fbbe0-11b7-4a41-9cfa-80242539c8c5, aws_security_group.cluster
             | Cluster uses subnets module.vpc.aws_subnet.public[0], module.vpc.aws_subnet.public[1], module.vpc.aws_subnet.public[2]
             | Subnets rely on NACL`s nacl-pseudo-c60baff2-bb3a-44d1-9750-d5162dd5f965, nacl-pseudo-c60baff2-bb3a-44d1-9750-d5162dd5f965, nacl-pseudo-c60baff2-bb3a-44d1-9750-d5162dd5f965
             | They also rely on Routing-Tables module.vpc.aws_route_table.public[0], module.vpc.aws_route_table.public[0], module.vpc.aws_route_table.public[0]
             | Cluster is set to be publicly accessible

```