When using VPC Endpoints, you want to make sure you also have the routing tables set to send traffic to the VPCE. Otherwise, 
you're not using it.

In this scenario, we have a VPC endpoint set, but no routing table associations. Therefore, Cloudrail flags it:

```
-----------------------------------------------
Rule: Ensure VPC Endpoint for DynamoDB is enabled in all route tables in use in a VPC
 - 1 Resources Exposed:
-----------------------------------------------
   - Exposed Resource: [aws_vpc.main] (main.tf:8)
     Violating Resource: [rt-pseudo-4870eef8-77b8-4754-9e1f-e0a6283ddc66]  (Not found in TF)

     Evidence:
             | The VPC ~aws_vpc.main~ has a DYNAMODB Endpoint Gateway, but ~aws_subnet.private-subnet~ uses ~rt-pseudo-4870eef8-77b8-4754-9e1f-e0a6283ddc66~, which does not have a route to the endpoint gateway
```