When VPC peering is set, each VPC declares its own CIDR block that it exposes.

For VPC peering to work, routing tables need to be updated to route traffic to the peer VPC.

Here, a best practice is to limit the routing to focus only on specific subnets. This way, you're not expoing your entire VPC to the peer.

Cloudrail is capable of analyzing the VPC peer's CIDR block against your routing tables, and determining when overly broad routes are being used.

If an issue is found, a violation will be highlighted:

```
Rule: Ensure used routing tables for VPC peering are "least access"
 - 1 Resources Exposed:
-----------------------------------------------
   - Exposed Resource: [aws_vpc.vpc2] (main.tf:35)
     Violating Resource: [aws_route_table.subnet2_1]  (main.tf:162)

     Evidence:
         VPC Peer aws_vpc.vpc1.id
             | VPC Peer uses CIDR block aws_vpc.vpc1.id
             | Local VPC's routing table aws_route_table.subnet2_1 has a route matching CIDR block
             | Local VPC is potentially overexposing resources peering VPC
         Local VPC aws_vpc.vpc2.id

```