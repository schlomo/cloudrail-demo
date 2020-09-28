# Cloudrail: context-aware cloud security tool

## Create the AWS IAM Role for Cloudrail

You will need to create an IAM role in your account in order for Cloudrail be able to use STS assume role to get temporary read access to your account.

Use "cloudrail add_cloud_account" command to generate the Terraform and CloudFormation templates to create the IAM Role. You can then use those templates to create the IAM Role in your account.
```
~ # cloudrail add_cloud_account
Before adding a cloud account, please make sure to create a role for Cloudrail to assume in your account with SecurityAudit and ViewOnlyAccess policies.

You can do this manually, or Cloudrail can generate a template for you to use (both CloudFormation and Terraform). Would you like us to generate the cloudrail_viewonly_role template? [YES]: 

Templates generated. You can use either:
    * Cloudformation: /root/cloudrail-demo/test/aws/terraform/ec2_role_share_rule/private_and_private_ec2_same_role/cloudrail_viewonly_role.yaml
    * Terraform: /root/cloudrail-demo/test/aws/terraform/ec2_role_share_rule/private_and_private_ec2_same_role/cloudrail_viewonly_role.tf
    
Once you have created the role, hit any key to continue (or 'q' to abort at this time and continue later)
```

At this point, you can use the Terraform or CloudFormation template to generate the IAM role in your account, or you can create the IAM role manually using the information contained in the templates:
- Indeni trusted account
- IAM Role policies (ViewOnlyAcccess, SecurityAudit)
- IAM Role name (the templates contain a unique name per customer)
- External ID (the templates contain a unique value per customer)

Once the IAM Role is created, you can continue with the execution of "cloudrail add_cloud_account" command to add your AWS account to the Cloudrail service or you can hit "q" in order to abort and continue later.

```
Enter the name of your cloud account: my-account
Enter the ID of your cloud account: XXXXXXXXXXXX

Thank you, that worked.

Please allow the Cloudrail Service some time to collect a snapshot of your live environment.
An email will be sent to you once ready.
```