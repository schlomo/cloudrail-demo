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

  1. EC2 Classic mode identified
  2. Default security group used
  3. Use of the same role for public and private EC2s found
  5. The ECS target is exposed publicly on several ports
  6. Use of default security group identified
  7. EC2 identified as a potential pivot point in reaching Rds cluster
  8. EC2 identified as a potential pivot point in reaching Redshift cluster
  9. RDS database found to be publicly accessible
  10. Redshift cluster public access identified
  11. Public access to port 22 found
  12. Use of Default VPC identified
  13. Violations found in the runtime variable
  14. Violations found in the TF Variables
  15. Use of overlapping CIDR blocks
  
  
</details>
