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

- [Find out if a public instance and a private instance use the same role](test/aws/terraform/ec2_role_share_rule/public_and_private_ec2_same_role)
- [Identify if a Default Security Group is in use AND open](test/aws/terraform/ensure_all_used_default_security_groups_restrict_all_traffic_rule/default_sg_in_new_vpc)
- [Take into consideration the account-level Public Access Block for S3 buckets](test/aws/terraform/s3_acl_disallow_public_and_cross_account/acl_public_all_authenticated_users_canned)
- [Calculate if a VPC endpoint should be used, and whether it's used correctly](test/aws/terraform/s3_vpce_gateway_not_used_rule/vpc_has_only_s3_vpce_gw_connection)
- [Do not alert about a resource being public if it isn't](test/aws/terraform/public_access_db_redshift_rule/redshift_without_public_access)

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

#### 1. Sign up and download container
Go to https://web.cloudrail.app to sign up for Cloudrail. This will include adding your cloud account, and will provide instructions for downloading and using the Cloudrail CLI container.

#### 2. Execute Terraform examples
Inside the ["test"](test/README.md) folder you will find several examples you can use to try Cloudrail with. Some of these examples will set up vulnerable resources that are detected by Cloudrail as such. A few of these examples are _not_ vulnerable, and are there to show Cloudrail's context awareness.

#### 3. Try your own scenarios
Now it's time for you to try Cloudrail with your own scenarios. Simply follow the same process - "terraform init", "terraform plan -out=plan.out" and "cloudrail run".

## Troubleshooting
If you encounter any error, please let us know in the Indeni Slack channel #cloudrail-user-support. An invite can be received by filling out the form here: https://indeni.com/cloudrail-user-support/
