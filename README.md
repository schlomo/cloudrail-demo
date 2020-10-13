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
#### 1. Installation & Upgrade
You can install Cloudrail with the following command:
```
~ # pip3 install cloudrail --extra-index-url https://indeni.jfrog.io/indeni/api/pypi/cloudrail-cli-pypi/simple
```
Once the installation is complete, you can verify the Cloudrail version with the command:
```
~ # cloudrail --version
cloudrail, version 0.1.213
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
Successfully register
Registration completed successfully. You can now begin to use the Cloudrail CLI tool.
```
You will need to provide a valid email address and a password. Password should include capital letters, numbers and special characters.

The registration will generate a file on your hard drive at ~/.cloudrail/config with your API key, Customer ID and Username.
You may choose to remove this file and retain the API key for your records. The API key can be provided as a parameter to the tool when using various commands.

#### 3. Login to Cloudrail service
If you ever need to regenerate the ~/.cloudrail/config file, use the login function:
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
