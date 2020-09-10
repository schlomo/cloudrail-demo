# Cloudrail: context-aware cloud security tool

## Contents

- [Overview](#overview)
- [Features](#features)
- [Requirements](#requirements)
- [Usage](#usage)
- [Test scenarios](#testscenarios)

## Overview
#### *Warning: Cloudrail is in version v0.1, so it should be used carefully.*
Cloudrail is a context-aware cloud security tool that will audit your cloud environment and your IaC templates in order to build a security context of the resources being deployed to determine the security risks.

## Features
Cloudrail currently supports AWS cloud provider and Terraform IaC language.

## Requirements
- Cloudrail needs Python >= 3.7 installed.
- Cloudrail needs an IAM Role in your account. You can configure this role either manually of using the Terraform cloudrail-role template example

## Usage
#### 1. Installation & Upgrade
You can install Cloudrail with the following command:
```sh
~ # pip3 install cloudrail --extra-index-url https://indeni.jfrog.io/indeni/api/pypi/cloudrail-cli-pypi/simple
```
Once the installation is completed, you can verify the Cloudrail version with the command:
```sh
~ # cloudrail --version
cloudrail, version 0.1.130
~ #
```
If you need to upgrade the Cloudrail version, you can run the following command:
```sh
~ # pip3 install cloudrail --upgrade --extra-index-url https://indeni.jfrog.io/indeni/api/pypi/cloudrail-cli-pypi/simple
```


#### 2. Register with Cloudrail service
Next step is to register with Cloudrail service.
```sh
~ # cloudrail register
Please enter the email address you would like to register with: xxx@xxx.com
The password you would like to use: 
Repeat for confirmation: 
Your Cloudrail Customer ID []: 
Successfully register
Registration completed successfully. You can now begin to use the Cloudrail CLI tool.
~ # 
```
You will need to provide a valid email address and a password. You can leave Cloudrail Customer ID in blank for demo purposes.


#### 3. Login to your Cloudrail service
Once the service registration has been completed, you will need to login with the Cloudrail service:
```sh
~ # cloudrail login
Your username [xxx@xxx.com]: xxx@xxx.com
Password: 
Successfully login
You are now logged in and can begin to use the Cloudrail CLI tool.
~ #
```


#### 4. Add your cloud account to Cloudrail service
Next step is to add your cloud account to the Cloudrail service in order to be able to audit it.
```sh
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
```sh
~ # cloudrail list_cloud_accounts
```

If you want to remove your cloud account from Cloudrail service:
```sh
~ # cloudrail remove_cloud_account
```


#### 5. Run Cloudrail
Now, you can run Cloudrail in order to audit your cloud account and your Terraform files:
```sh
~ # cloudrail run
Enter terraform plan file path: XXXXXXXX
Enter root directory of the .tf files. (Leave empty to use the plan path) []: XXXXXXXX
( ●    ) Uploading Terraform plan file to the Cloudrail Service
Successfully uploaded Terraform plan file, your job id is: 6909ae1f-2bc3-4f60-8e9b-5500cf56b110

WARNINGs found:
  Rule: The inbound traffic of an EC2(s) must first go through a particular network node
     - Rule Description:
     - 1 misplaced ec2s were found:
       - Instance Name: aws_instance.bastion.id VPC Id: vpc-819f5ef8 Public IP(s): ['0.0.0.0'] Private IP(s): 172.31.0.0

  Rule: Ensure no used security groups allow ingress from 0.0.0.0/0 or ::/0 to port 22 (SSH)
     - Rule Description:
     - Ensure no used security groups allow inbound connections from 0.0.0.0/0 or ::/0 to port 22 (SSH). security issue=1 are in used and exposing instances to SSH from the Internet
       - SG permission: from_port=22, to_port=22, ip_protocol=tcp, property_type=SecurityGroupRulePropertyType.IP_RANGES, property_value=0.0.0.0/0 is exposing ENI id=eni-fk-d1cd07b6-b4f0-43d4-a515-20352b7a3cce owned by=Instance Name: aws_instance.bastion.id VPC Id: vpc-819f5ef8 Public IP(s): ['0.0.0.0'] Private IP(s): 172.31.0.0 to SSH from the Internet

Summary:
X cloud resources analyzed by Cloudrail
Y cloud resources identified as managed by Terraform

2 rule violations found:
  2 WARNINGs
  21 PASS


NOTE: WARNINGs are not listed by default. Please use the "-v" option to list them.
```

## Test scenarios
PENDING
