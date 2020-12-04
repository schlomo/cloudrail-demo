# Cloudrail: context-aware cloud security tool

## Test examples

To try any of these test cases, go to the specific test case's directory, create a TF plan and run an evaluation with Cloudrail. For example:

```
~/test/aws/terraform/public_access_security_groups_port_rule/port_22_allowed_from_internet_to_ec2_explicit # terraform init
~/test/aws/terraform/public_access_security_groups_port_rule/port_22_allowed_from_internet_to_ec2_explicit # terraform plan -out=plan.out
~/test/aws/terraform/public_access_security_groups_port_rule/port_22_allowed_from_internet_to_ec2_explicit # cloudrail run
Enter terraform plan file path: /root/test/aws/terraform/public_access_security_groups_port_rule/port_22_allowed_from_internet_to_ec2_explicit/plan.out
Enter root directory of the .tf files. (Leave empty to use the plan path) []: 
(  ●   ) Uploading Terraform plan file to the Cloudrail Service
Successfully uploaded Terraform plan file, your job id is: f0366780-de4c-477c-8646-8b2c50e74096

WARNINGs found:
  Rule: Ensure no used security groups allow ingress from 0.0.0.0/0 or ::/0 to port 22 (SSH)
     - Rule Description:
     - Ensure no used security groups allow inbound connections from 0.0.0.0/0 or ::/0 to port 22 (SSH). security issue=1 are in used and exposing instances to SSH from the Internet
       - SG permission: from_port=22, to_port=22, ip_protocol=tcp, property_type=SecurityGroupRulePropertyType.IP_RANGES, property_value=0.0.0.0/0 is exposing ENI id=eni-fk-41f30735-36f1-4612-a8b9-2459da3d7ef7 owned by=Instance Name: PublicAccessSecurityGroupsPort test - use case 2 VPC Name: PublicAccessSecurityGroupsPort test - use case 2 Public IP(s): ['0.0.0.0'] Private IP(s): 10.10.0.0 to SSH from the Internet

Summary:
X cloud resources analyzed by Cloudrail
Y cloud resources identified as managed by Terraform

1 rule violations found:
  1 WARNINGs
  24 PASS



NOTE: WARNINGs are not listed by default. Please use the "-v" option to list them.

~ #
```

NOTE: You do not need to run "terraform apply" as Cloudrail can simply analyze the plan. If you would like, you can apply the entire test case in your AWS account and see you are getting the same results.
If you'd like to be even more creative, you can apply some of the resources first, then run a plan that will add only the remaining resources. Cloudrail is capable of understanding all of these scenarios.

# Test Cases to try Cloudrail With
<details>
  <summary>AWS</summary>

  1. [EC2 Classic mode identified](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/disallow_ec2_classic_mode_rule/deploy_redshift_in_ec2_classic_mode)
  2. [Default security group used](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/ensure_all_used_default_security_groups_restrict_all_traffic_rule/default_sg_in_new_vpc)
  3. [Use of the same role for public and private EC2s found](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/ec2_role_share_rule/public_and_private_ec2_same_role)
  5. [The ECS target is exposed publicly on several ports](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/ecs_entity_expose_port_to_public_connections/ecs_schedule_task_expose_port)
  6. [Use of default security group identified](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/ensure_all_used_default_security_groups_restrict_all_traffic_rule/default_sg_in_new_vpc)
  7. [EC2 identified as a potential pivot point in reaching Rds cluster](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/indirect_public_access_db_rds/public_ec2_points_to_private_rds)
  8. [EC2 identified as a potential pivot point in reaching Redshift cluster](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/indirect_public_access_db_redshift/public_ec2_points_to_private_redshift)
  9. [RDS database found to be publicly accessible](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/public_access_db_rds/aurora/vpc-controlled-public)
  10. [Redshift cluster public access identified](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/public_access_db_redshift_rule/redshift_with_public_access)
  11. [Public access to port 22 found](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/public_access_security_groups_port_rule/bastion_server)
  12. [Use of Default VPC identified](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/test_disallow_default_vpc/deploy_ec2_to_default_vpc)
  13. [Violations found in the runtime variable](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/test_runtime_variables)
  14. [Violations found in the TF Variables](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/test_tfvars)
  15. [Use of overlapping CIDR blocks](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/vpcs_in_tgw_no_overlapping_cidr_rule/overlapping_routes)
  16. [Loadbalancers should not use HTTP for target groups](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/alb_disallow_target_groups_http_rule/alb_use_http)
  17. [Cloudfront protocol version should be high](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/cloudfront_distributiion_list/cloudfront_protocol_version_is_low)
  18. [EKS logging should be enabled](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/eks_logging_disable/failure)
  19. [Default Security Groups, when used, shoudl restrict all traffic](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/ensure_all_used_default_security_groups_restrict_all_traffic_rule/ec2_simple_deceleration)
  20. [ES domain is indirectly accessible from public EC2](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/indirect_public_access_es_domain/public_ec2_points_to_private_domain)
  21. [VPC Peering should not be allowed in this environment](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/no_vpc_peering_allowed_rule/simple_vpc_peering_scenario)
  22. [EKS should not have a publically exposable API](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/public_access_eks_api/eks_with_public_api)
  23. [Loadbalancer should not expose port 22 to the internet](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/public_access_security_groups_port_rule/port_22_allowed_from_internet_to_load_balancer_explicit)
  24. [S3 buckets should not be accessible from the public and cross-account](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/s3_acl_disallow_public_and_cross_account/acl_public_all_authenticated_users_canned)
  25. [VPC Endpoint Gateway should be used for S3 buckets](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/s3_vpce_gateway_not_used_rule/vpc_do_not_have_direct_s3_service_connection)
  26. [Cloudfront distribution should encrypt data in transit](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/test_ensure_cloudfront_distribution_encrypt_in_transit_rule/not_encrypted)
  27. [VPC Peers should have routes defined with least-access](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/test_vpc_peering_least_access/routes_too_permissive_wider_than_VPC)
  28. [API Gateway caching should be encrypted](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/encrypted_rest_api)
  29. [No IAM user should be defined](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/iam_no_human_users_role)
  30. [Redshift clusters should be encrypted at rest](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/ensure_redshift_cluster_created_encrypted_rule)
  31. [Enforce the use of VPC Endpoint gateways for S3](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/s3_vpce_gateway_not_used_rule)
  32. [Enforce the use of VPC Endpoint gateways for DynamoDB for VPCs](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/dynamodb_vpce_gateway_not_used_rule)
  33. [Enforce the use of VPC Endpoint gateways for DynamoDB for Route Tables](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/dynamodb_vpce_gateway_route_table_exposure_rule)
  
</details>
