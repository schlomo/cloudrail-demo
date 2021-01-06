# Cloudrail: context-aware cloud security tool

## Create the AWS IAM Role for Cloudrail

You will need to create an IAM role in your account in order for Cloudrail be able to use STS assume role to get temporary read access to your account.

Use the ```cloudrail add-cloud-account``` command to generate the Terraform and CloudFormation templates to create the IAM Role. You can then use those templates to create the IAM Role in your account.
```
~ # cloudrail add-cloud-account
Make sure you can create a role for Cloudrail to assume in your account with SecurityAudit and ViewOnlyAccess policies.

cloudrail_viewonly_role template? [YES]: 

Templates generated. You can use either:
    * Cloudformation: /root/cloudrail-demo/test/aws/terraform/ec2_role_share_rule/private_and_private_ec2_same_role/cloudrail_viewonly_role.yaml
    * Terraform: /root/cloudrail-demo/test/aws/terraform/ec2_role_share_rule/private_and_private_ec2_same_role/cloudrail_viewonly_role.tf
    
Once you have created the role, hit any key to continue (or 'q' to abort at this time and continue later)
```

At this point, you can use the Terraform or CloudFormation template to generate the IAM role in your account, or you can create the IAM role manually using the information provided by the Cloudrail CLI tool (if you choose "no" at the prompt).

Once the IAM Role is created, you can continue with the execution of ```cloudrail add-cloud-account``` command to add your AWS account to the Cloudrail service or you can hit "q" in order to abort and continue later.

```
Enter the name of your cloud account: my-account
Enter the ID of your cloud account: XXXXXXXXXXXX

Thank you, that worked.

Please allow the Cloudrail Service some time to collect a snapshot of your live environment.
```

Note that when doing so, the Cloudrail Service will attempt to access your cloud account through a simple test (trying to assume the role). If it fails, an error message will be shown.