# Cloudrail: context-aware cloud security tool

## Contents

- [Overview](#overview)
- [Features](#features)
- [Requirements](#requirements)
- [Usage](#usage)
- [Troubleshooting](#troubleshooting)

## Overview
#### *Warning: Cloudrail is in version v0.1. Please use it with development or small environments to begin with.*
Cloudrail is a context-aware cloud security tool that will audit your cloud environment and your IaC templates in order to build a security context of the resources being deployed to determine the security risks. 
The goal of Cloudrail is to be integrated within a CI/CD process to catch violations of your security policy before they make it into the production environment.

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
```

The login will generate a file on your hard drive at ~/.cloudrail/config with your API key, Customer ID and Username.
You may choose to remove this file and retain the API key for your records. The API key can be provided as a parameter to the tool when using various commands.


#### 4. Create the AWS IAM Role for Cloudrail
Please, follow the instructions [here](docs/cloudrail-role/README.md) in order to create the AWS IAM Role for Cloudrail.


#### 5. Add your cloud account to Cloudrail service
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
Inside the "test" folder you will find several examples you can use to try Cloudrail with. Some of these examples will set up vulnerable resources that are detected by Cloudrail as such. A few of these examples are _not_ vulnerable, and are there to show Cloudrail's context awareness.

#### 6. Try your own scenarios
Now it's time for you to try Cloudrail with your own scenarios. Simply follow the same process - "terraform init", "terraform plan -out=plan.out" and "cloudrail run".

## Troubleshooting
If you encounter any error, please let us know in the Indeni Slack channel #cloudrail-user-support. An invite can be received by filling out the form here: https://indeni.com/cloudrail-user-support/
