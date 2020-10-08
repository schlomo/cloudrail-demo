# Cloudrail: context-aware cloud security tool

## Contents

- [Overview](#overview)
- [Features](#features)
- [Requirements](#requirements)
- [Usage](#usage)
- [Troubleshooting](#troubleshooting)

## Overview
#### *Warning: Cloudrail is in version v0.1. Please use it with development or small environments to begin with. It only supports Terraform with AWS at the moment.*
Cloudrail is a context-aware cloud security tool that will audit your cloud environment and your IaC templates in order to build a security context of the resources being deployed to determine the security risks. 
The goal of Cloudrail is to be integrated within a CI/CD process to catch violations of your security policy before they make it into the production environment.

Cloudrail's main advantages vs existing tools are:
- The understanding of relationships between resources (for example, a given security group can be problematic or not, depending on how it's used)
- Taking into account the live cloud environment, and its potential impact on the resources in the IaC code
- Support for tfvars, runtime variables and modules (Cloudrail reviews the full plan, instead of specific .tf files)

## Features
Cloudrail currently supports Terraform files used with the AWS cloud provider.

## Requirements
- Python >= 3.8

## Usage
#### 0. Create the AWS IAM Role for Cloudrail
You will need to create an IAM role in your account in order for Cloudrail be able to use STS assume role to get temporary read access to your account.

- Trusted account ID: 645376637575 (This is the account used by Indeni Cloudrail service)
- Specify an External ID (you will need this value when configuring Cloudrail CLI in the next steps)
- Attach the "ReadOnlyAccess" AWS Managed policy.

<kbd>
<img src="/docs/images/cloudrail-role-01.png" alt="Cloudrail-role-01" title="Create Cloudrail IAM role trusted policy"/>
</kbd>
<br><br>
<kbd>
<img src="/docs/images/cloudrail-role-02.png" alt="Cloudrail-role-02" title="Create Cloudrail IAM role permissions policy"/>
</kbd>

#### 1. Installation & Upgrade
You can install Cloudrail with the following command:
```
~ # pip3 install cloudrail --extra-index-url https://indeni.jfrog.io/indeni/api/pypi/cloudrail-cli-pypi/simple
```
Once the installation is complete, you can verify the Cloudrail version with the command:
```
~ # cloudrail --version
cloudrail, version 0.1.138
```
NOTE: If the installation completed successfully, but the above command fails, please try opening a new shell window or restarting.

If you need to upgrade the Cloudrail version, you can run the following command:
```
~ # pip3 install cloudrail --upgrade --extra-index-url https://indeni.jfrog.io/indeni/api/pypi/cloudrail-cli-pypi/simple
```


#### 2. Register with Cloudrail service
Next step is to register with the Cloudrail service.
```
~ # cloudrail register
Please enter the email address you would like to register with: xxx@xxx.com
The password you would like to use: 
Repeat for confirmation: 
Your Cloudrail Customer ID []: 
Successfully register
Registration completed successfully. You can now begin to use the Cloudrail CLI tool.
~ # 
```
You will need to provide a valid email address and a password. You can leave Cloudrail Customer ID empty for demo purposes.


#### 3. Login to Cloudrail service
Once the service registration has been completed, you will need to login with the Cloudrail service:
```
~ # cloudrail login
Your username [xxx@xxx.com]: xxx@xxx.com
Password: 
Successfully login
You are now logged in and can begin to use the Cloudrail CLI tool.
~ #
```

The login will generate a file on your hard drive at ~/.cloudrail/config with your API key, Customer ID and Username.
You may choose to remove this file and retain the API key for your records. The API key can be provided as a parameter to the tool when using various commands.

#### 4. Add your cloud account to Cloudrail service
You need to add your cloud account to the Cloudrail service. You have to provide:
- A name for your account. This name is just for identification purposes inside your Cloudrail service.
- Your account ID
- The AWS IAM Role ARN created in step #0
- The AWS IAM Role external ID created in step #0
```
~ # cloudrail add_cloud_account
Enter the name of your cloud account: ZZZZZ
Enter the ID of your cloud account: XXXXXXXXXXXX
Enter the ARN of the role created in your account for Cloudrail: arn:aws:iam::XXXXXXXXXXXX:role/ROLE_NAME
Enter the role External ID: YYYYYYYYYY
(     ●) Adding account

Thank you, that worked.

Please allow the Cloudrail Service some time to collect a snapshot of your live environment.
An email will be sent to you once ready.
```

You can also list your cloud accounts that have been added to Cloudrail service:
```
~ # cloudrail list_cloud_accounts
```

If you want to remove your cloud account from Cloudrail service:
```
~ # cloudrail remove_cloud_account
```

#### 5. Execute Terraform examples
Inside the "test" folder you will find several examples you can use to try Cloudrail with (list below). Some of these examples will set up vulnerable resources that are detected by Cloudrail as such. A few of these examples are _not_ vulnerable, and are there to show Cloudrail's context awareness.

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

| Test Case | Expected Result |
| --- | --- |
| ~/test/aws/terraform/disallow_ec2_classic_mode_rule/deploy_redshift_in_ec2_classic_mode | Use of EC2 Classic mode identified |
| ~/test/aws/terraform/disallow_ec2_classic_mode_rule/deploy_redshift_in_ec2_vpc_mode | No violation |
| ~/test/aws/terraform/ec2_role_share_rule/private_and_private_ec2_same_role | No violation |
| ~/test/aws/terraform/ec2_role_share_rule/public_and_private_ec2_different_role | No violation |
| ~/test/aws/terraform/ec2_role_share_rule/public_and_private_ec2_same_role | Use of the same role for public and private EC2s found |
| ~/test/aws/terraform/ec2_role_share_rule/public_and_public_ec2_same_role | No violation |
| ~/test/aws/terraform/ecs_entity_expose_port_to_public_connections/ecs_schedule_task_expose_port | Scheduled task exposed publicly | 
| ~/test/aws/terraform/ecs_entity_expose_port_to_public_connections/ecs_schedule_task_not_expose_any_port | No violation |
| ~/test/aws/terraform/ecs_entity_expose_port_to_public_connections/ecs_service_expose_port | Publicly exposed port found |
| ~/test/aws/terraform/ecs_entity_expose_port_to_public_connections/ecs_service_not_expose_any_port | No violation |
| ~/test/aws/terraform/ensure_all_used_default_security_groups_restrict_all_traffic_rule/decelerated_sg_in_new_vpc | No violation |
| ~/test/aws/terraform/ensure_all_used_default_security_groups_restrict_all_traffic_rule/decelerated_sg_with_rules_in_new_vpc | Violation found |
| ~/test/aws/terraform/ensure_all_used_default_security_groups_restrict_all_traffic_rule/default_sg_in_new_vpc | Use of default security group identified |
| ~/test/aws/terraform/ensure_all_used_default_security_groups_restrict_all_traffic_rule/default_sg_with_ec2_using_ni | Use of default security group identified |
| ~/test/aws/terraform/ensure_all_used_default_security_groups_restrict_all_traffic_rule/ec2_simple_deceleration | Use of default security group identified |
| ~/test/aws/terraform/indirect_public_access_db_rds/private_ec2_points_to_private_rds | No violation |
| ~/test/aws/terraform/indirect_public_access_db_rds/public_ec2_points_to_private_rds | EC2 identified as a potential pivot point in reaching Redshift cluster |
| ~/test/aws/terraform/indirect_public_access_db_redshift/private_ec2_points_to_private_redshift | No violation |
| ~/test/aws/terraform/indirect_public_access_db_redshift/public_ec2_points_to_private_redshift | EC2 identified as a potential pivot point in reaching Redshift cluster |
| ~/test/aws/terraform/public_access_db_rds/aurora/defaults-only | No violation |
| ~/test/aws/terraform/public_access_db_rds/aurora/vpc-controlled | No violation |
| ~/test/aws/terraform/public_access_db_rds/aurora/vpc-controlled-public | RDS database found to be publicly accessible |
| ~/test/aws/terraform/public_access_db_rds/individual-instance/defaults-only | No violation |
| ~/test/aws/terraform/public_access_db_rds/individual-instance/defaults-with-public-on | No violation |
| ~/test/aws/terraform/public_access_db_rds/individual-instance/vpc-controlled-not-public | No violation |
| ~/test/aws/terraform/public_access_db_rds/individual-instance/vpc-controlled-public | RDS database found to be publicly accessible |
| ~/test/aws/terraform/public_access_db_redshift_rule/redshift_with_public_access | Redshift cluster public access identified |
| ~/test/aws/terraform/public_access_db_redshift_rule/redshift_without_public_access | No violation |
| ~/test/aws/terraform/public_access_security_groups_port_rule/atlantis_only | Public access found |
| ~/test/aws/terraform/public_access_security_groups_port_rule/bastion_server | Public access to port 22 found |
| ~/test/aws/terraform/public_access_security_groups_port_rule/port_22_allowed_from_internet_but_instance_on_private_subnet | No violation |
| ~/test/aws/terraform/public_access_security_groups_port_rule/port_22_allowed_from_internet_to_ec2_explicit | Public access through port 22 found |
| ~/test/aws/terraform/public_access_security_groups_port_rule/port_22_allowed_from_internet_to_ec2_using_tf_complete_vpc_module | Public access through port 22 found |
| ~/test/aws/terraform/public_access_security_groups_port_rule/port_22_allowed_from_internet_to_ec2_using_tf_instance_module | Public access through port 22 found |
| ~/test/aws/terraform/public_access_security_groups_port_rule/port_22_allowed_from_internet_to_ec2_using_tf_ssh_module | Public access through port 22 found |
| ~/test/aws/terraform/test_disallow_default_vpc/deploy_ec2_to_default_vpc | Use of Default VPC identified |
| ~/test/aws/terraform/test_disallow_default_vpc/deploy_ec2_to_specific_vpc | No violation |
| ~/test/aws/terraform/vpcs_in_tgw_no_overlapping_cidr_rule/overlapping_routes | Use of overlapping CIDR blocks identified |
| ~/test/aws/terraform/vpcs_in_tgw_no_overlapping_cidr_rule/typical_setup_no_issue | No violation |

#### 5. Try your own scenarios
Now it's time for you to try Cloudrail with your own scenarios. Simply follow the same process - "terraform init", "terraform plan -out=plan.out" and "cloudrail run".

## Troubleshooting
If you encounter any error, please let us know in the Indeni Slack channel #cloudrail-user-support. An invite can be received by filling out the form here: https://indeni.com/cloudrail-user-support/
