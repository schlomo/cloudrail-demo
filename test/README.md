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
  
  
</details>
