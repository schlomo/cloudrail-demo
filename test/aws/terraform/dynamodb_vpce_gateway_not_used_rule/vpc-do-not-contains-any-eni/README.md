This is an example of a non-issue scenario which employs context analysis.

In this specific case, we are creating a situation where a DynamoDB table is used without a VPC endpoint. Normally, that would be a problem,
however, in this case, there are no resources in the VPC which can connect to the DynamoDB. Therefore, there's no need for a VPC endpoint.

When checking whether a VPC has resource or not, we also look at the live cloud environment, in case the VPC already exists and resources
were put into it outside of the Terraform plan.

This is an example of how Cloudrail's context analysis reduces noise.