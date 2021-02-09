This is a simple example of using Indeni Cloudrail with Terragrunt. Notice that we're using an after hook,
to make it easier to integrate Cloudrail with the execution of many plans.

If Cloudrail finds a violation in a mandated rule, it will return a non-zero exit code, which
Terragrunt will then bubble up. Example:

```
# terragrunt plan -out plan.out
[terragrunt] 2021/02/09 10:50:56 Reading Terragrunt config file at /Users/grunt/code/cloudrail-demo/terragrunt/terragrunt.hcl
[terragrunt] [/Users/grunt/code/cloudrail-demo/terragrunt] 2021/02/09 10:50:56 Running command: terraform --version
[terragrunt] [/Users/grunt/code/cloudrail-demo/terragrunt] 2021/02/09 10:51:00 Running command: terraform init
...
[terragrunt] [/Users/grunt/code/cloudrail-demo/terragrunt] 2021/02/09 10:51:17 Detected 1 Hooks
[terragrunt] 2021/02/09 10:51:17 Running command: terraform plan -out plan.out
...

This plan was saved to: plan.out

To perform exactly these actions, run the following command to apply:
    terraform apply "plan.out"

[terragrunt] 2021/02/09 10:51:35 Detected 1 Hooks
[terragrunt] 2021/02/09 10:51:35 Executing hook: cloudrail_after_hook
[terragrunt] 2021/02/09 10:51:35 Running command: docker run --rm -v /Users/grunt/code/cloudrail-demo/terragrunt:/data indeni/cloudrail-cli run -d . --tf-plan plan.out --origin ci --build-link https://somelink --execution-source-identifier build-id --api-key myapikey --auto-approve
Preparing a filtered Terraform plan locally before uploading to Cloudrail Service...
Running a customized Terraform show using a customized version of Terraform to produce a detailed resource map. This is the longest phase of the evaluation, as it includes downloading Terraform plugins and providers, as well as a re-calculation of the plan...
Filtering and processing Terraform data...
Obfuscating IP addresses...
Submitting Terraform data to the Cloudrail Service...
Your job id is: 15b4201b-3a7f-4660-b5b6-0ec39c4d5184
Cloudrail Service accessing the latest cached snapshot of cloud account 123456789012. Timestamp: 2021-02-09 15:41:34Z...
Building simulated graph model, representing how the cloud account will look like if the plan were to be applied...
Running context-aware rules...
Returning results, almost done!
Assessment complete, fetching results...

ERRORs found:
Rule: EC2(s) within the public and private subnets should not share identical IAM roles
Description: Having the same IAM role for both public and private instances may be dangerous. Someone may expand the permissions for the role in order to use it in a private workload, not realizing a public workload has the same privileges.
 - 1 Resources Exposed:
-----------------------------------------------
   - Exposed Resource: [aws_instance.priv_ins] (main.tf:107)
     Violating Resource: [aws_iam_role.test_role]  (main.tf:51)

     Evidence:
         Instance ['aws_instance.pub_ins']
             | Instance is publicly exposed
             | Instance uses IAM role aws_iam_role.test_role
             | Private EC2 instance shares IAM role aws_iam_role.test_role as well
         Instance aws_instance.priv_ins


-----------------------------------------------

Summary:
7 Rules Violated:
  1 Mandated Rules (these are considered FAILURES)
  6 Advisory Rules (these are considered WARNINGS)
111 Rules Passed

NOTE: WARNINGs are not listed by default. Please use the "-v" option to list them.

To view this assessment in the Cloudrail Web UI, go to https://web.cloudrail.app/environments/assessments/15b4201b-3a7f-4660-b5b6-0ec39c4d5184
[terragrunt] 2021/02/09 10:52:21 Error running hook cloudrail_after_hook with message: exit status 1
[terragrunt] 2021/02/09 10:52:21 Hit multiple errors:
Hit multiple errors:
exit status 1
```

Whereas, if there are no violations were found for mandated rules, the end of the execution would look like this:

```
[terragrunt] 2021/02/09 10:59:13 Running command: docker run --rm -v /Users/grunt/code/cloudrail-demo/terragrunt:/data indeni/cloudrail-cli run -d . --tf-plan plan.out --origin ci --build-link https://somelink --execution-source-identifier build-id --api-key myapikey --auto-approve
Preparing a filtered Terraform plan locally before uploading to Cloudrail Service...
Running a customized Terraform show using a customized version of Terraform to produce a detailed resource map. This is the longest phase of the evaluation, as it includes downloading Terraform plugins and providers, as well as a re-calculation of the plan...
Filtering and processing Terraform data...
Obfuscating IP addresses...
Submitting Terraform data to the Cloudrail Service...
Your job id is: 6081f56b-f468-4909-896a-2d2e347ffbf3
Cloudrail Service accessing the latest cached snapshot of cloud account 123456789012. Timestamp: 2021-02-09 15:41:34Z...
Building simulated graph model, representing how the cloud account will look like if the plan were to be applied...
Running context-aware rules...
Returning results, almost done!
Assessment complete, fetching results...


Summary:
6 Rules Violated:
  0 Mandated Rules (these are considered FAILURES)
  6 Advisory Rules (these are considered WARNINGS)
112 Rules Passed

NOTE: WARNINGs are not listed by default. Please use the "-v" option to list them.

To view this assessment in the Cloudrail Web UI, go to https://web.cloudrail.app/environments/assessments/6081f56b-f468-4909-896a-2d2e347ffbf3
```

Note that Terragrunt doesn't print anything about the exit code if the hook was successful.