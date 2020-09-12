# Cloudrail: context-aware cloud security tool

## Contents

- [Overview](#overview)
- [Features](#features)
- [Requirements](#requirements)
- [Usage](#usage)
- [Troubleshooting](#troubleshooting)

## Overview
#### *Warning: Cloudrail is in version v0.1, so it should be used carefully.*
Cloudrail is a context-aware cloud security tool that will audit your cloud environment and your IaC templates in order to build a security context of the resources being deployed to determine the security risks.

## Features
Cloudrail currently supports AWS cloud provider and Terraform IaC language.

## Requirements
- Python >= 3.8

## Usage
#### 0. Create the AWS IAM Role for Cloudrail
You will need to create an IAM role in your account in order to Cloudrail be able to use STS assume role to get temporary read access to your account.

- Trusted account ID: 167389268608 (This is the account used by Indeni Cloudrail service)
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
Once the installation is completed, you can verify the Cloudrail version with the command:
```
~ # cloudrail --version
cloudrail, version 0.1.138
~ #
```
If you need to upgrade the Cloudrail version, you can run the following command:
```
~ # pip3 install cloudrail --upgrade --extra-index-url https://indeni.jfrog.io/indeni/api/pypi/cloudrail-cli-pypi/simple
```


#### 2. Register with Cloudrail service
Next step is to register with Cloudrail service.
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
(     ●) Adding account/usr/lib/python3.8/site-packages/dataclasses_json/core.py:171: RuntimeWarning: `NoneType` object value of non-optional type status detected when decoding AccountConfigDTO.
  warnings.warn(f"`NoneType` object {warning}.", RuntimeWarning)

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
Inside the "test" folder you will find several examples to deploy vulnerable resource configurations to be detected by Cloudrail.
```
~/test/aws/terraform/public_access_security_groups_port_rule/port_22_allowed_from_internet_to_ec2_explicit # terraform init
~/test/aws/terraform/public_access_security_groups_port_rule/port_22_allowed_from_internet_to_ec2_explicit # terraform plan -out=plan.out
~/test/aws/terraform/public_access_security_groups_port_rule/port_22_allowed_from_internet_to_ec2_explicit # terraform apply
```

Please, be aware of the extra costs in your cloud account.


#### 6. Run Cloudrail
Now, you can run Cloudrail in order to audit your cloud account and your Terraform files:
```
~ # cloudrail run
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


<kbd>
<img src="/docs/images/cloudrail-run-01.png" alt="Cloudrail-run-01" title="Run cloudrail"/>
</kbd>
<br><br>


#### 7. Destroy Terraform resources
Remember to destroy any resources created during tests to avoid incurring in additional cloud costs.
```
~/test/aws/terraform/public_access_security_groups_port_rule/port_22_allowed_from_internet_to_ec2_explicit # terraform destroy
```

## Troubleshooting
If you encounter any error, please let us know in Indenit Slack channel #cloudrail-user-support
