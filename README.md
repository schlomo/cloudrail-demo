# Indeni Cloudrail: context-aware cloud security tool

## Contents

- [Overview](#overview)
- [Features](#features)
- [Requirements](#requirements)
- [Usage](#usage)
- [Troubleshooting](#troubleshooting)

## Overview
#### *Important: Cloudrail is not GA yet. Please use it with development or small environments to begin with. It only supports Terraform with AWS at the moment.*
Cloudrail is a context-aware cloud security tool that will audit your cloud environment and your IaC templates in order to build a security context of the resources being deployed to determine the security risks. 
The goal of Cloudrail is to be integrated within a CI/CD pipeline to catch violations of your security policy before they make it into the production environment.

Cloudrail's main advantages vs existing tools are:
- The understanding of relationships between resources (for example, a given security group can be problematic or not, depending on how it's used)
- Taking into account the live cloud environment, and its potential impact on the resources in the IaC code
- Support for tfvars, runtime variables and modules (Cloudrail reviews the full plan, instead of specific .tf files)

## Examples of Cloudrail-only capabilities

- [Find out if a public instance and a private instance use the same role](test/aws/terraform/ec2_role_share_role/public_and_private_ec2_same_role)
- [Identify if a Default Security Group is in use AND open](test/aws/terraform/ensure_all_used_default_security_groups_restrict_all_traffic_rule/default_sg_in_new_vpc)
- [Take into consideration the account-level Public Access Block for S3 buckets](test/aws/terraform/s3_acl_disallow_public_and_cross_account/acl_public_all_authenticated_users_canned)
- [Calculate if a VPC endpoint should be used, and whether it's used correctly](test/aws/terraform/s3_vpce_gateway_not_used_rule/vpc_has_only_s3_vpce_gw_connection)

## Features
Cloudrail currently supports Terraform files used with the AWS cloud provider.

## Requirements
- Container execution environment (such as Docker Desktop)
- Terraform >= 0.12

## How does Cloudrail work?
Cloudrail is a cloud-hosted service (SaaS) that receives a filtered version of your Terraform plan,
merges it (in memory) with your cloud account's current snapshot, and runs context-aware rules on the merged model. 
To do this, the Cloudrail CLI container will receive your Terraform plan, reduce it to a minimal version we need for analysis
(what we call "Terraform context"), and then upload that minimal version to our service. 

This ensures no highly-sensitive content from the plan ever leaves your network.

## Usage
#### 1. Installation & Upgrade
The CLI portion of Cloudrail is delivered as a container:
https://hub.docker.com/r/indeni/cloudrail-cli

You can start by pulling the container:
```
docker pull indeni/cloudrail-cli
```

Then, you can run the container:
```
docker run --rm -it -v $PWD:/data -v cloudrail:/indeni indeni/cloudrail-cli --version
```

When running on your own workstation, we recommend adding this function to your shell's .rc file (~/.bashrc, ~/.zshrc, etc.):
```shell script
cloudrail () {
  printf 'Checking for an updated cloudrail image (may take a few minutes if a new one is downloaded)...'
  docker pull indeni/cloudrail-cli > /dev/null
  printf '\r                                                                                                 \n'
  docker run --rm -it -v $PWD:/data -v cloudrail:/indeni indeni/cloudrail-cli $@
}
```
This will allow you to simply run ```cloudrail``` instead of the full docker command. Note that in
all of the examples below, we write ```cloudrail```. If you haven't included the above function in your 
shell's .rc file, you will need to use ```docker run --rm -it -v $PWD:/data -v cloudrail:/indeni indeni/cloudrail-cli``` instead.

#### 2. Register with Cloudrail service
Next step is to register with the Cloudrail service.
```
~ # cloudrail register
Please enter the email address you would like to register with: xxx@xxx.com
The password you would like to use: 
Repeat for confirmation: 
Successfully register
Registration completed successfully. You can now begin to use the Cloudrail CLI tool.
```
You will need to provide a valid email address and a password. Password should include at least one upper case letter, one lower case letter, a number, a special character, and be 6 characters long.

The registration will store a configuration file on the ```cloudrail``` docker volume. This volume will be accessible in future executions.
The file contains your API key, Customer ID and Username. You may choose to remove this file and supply the API key in all of the 
future Cloudrail CLI executions you make (via the argument ```--api-key```).

#### 3. Login to Cloudrail service
If you have already registered and want to regenerate the configuration file on the ```cloudrail``` docker volume, use the login function:
```
~ # cloudrail login
Your username [xxx@xxx.com]: xxx@xxx.com
Password: 
Successfully login
You are now logged in and can begin to use the Cloudrail CLI tool.
```

#### 4. Create the AWS IAM Role and add your AWS account to Cloudrail service
Please, follow the instructions [here](docs/cloudrail-role/README.md) in order to create the AWS IAM Role for Cloudrail.

You can also list your cloud accounts that have been added to Cloudrail service:
```
~ # cloudrail list-cloud-accounts
```

If you want to remove your cloud account from Cloudrail service:
```
~ # cloudrail remove-cloud-account
```

#### 5. Execute Terraform examples
Inside the ["test"](test/README.md) folder you will find several examples you can use to try Cloudrail with. Some of these examples will set up vulnerable resources that are detected by Cloudrail as such. A few of these examples are _not_ vulnerable, and are there to show Cloudrail's context awareness.

#### 6. Try your own scenarios
Now it's time for you to try Cloudrail with your own scenarios. Simply follow the same process - "terraform init", "terraform plan -out=plan.out" and "cloudrail run".

## Troubleshooting
If you encounter any error, please let us know in the Indeni Slack channel #cloudrail-user-support. An invite can be received by filling out the form here: https://indeni.com/cloudrail-user-support/
