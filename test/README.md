# Cloudrail: context-aware cloud security tool

## Test examples

To try any of these test cases, go to the specific test case's directory, create a TF plan and run an evaluation with Cloudrail. For example:

```
# cd test/aws/terraform/disallow_ec2_classic_mode_rule/deploy_redshift_in_ec2_classic_mode
# terraform init
# terraform plan -out=plan.out
# cloudrail run --tf-plan plan.out --directory . --auto-approve
```

NOTES:
1. You do not need to run ```terraform apply``` as Cloudrail can simply analyze the plan. If you would like, you can apply the entire test case in your AWS account and see you are getting the same results. If you'd like to be even more creative, you can apply some of the resources first, then run a plan that will add only the remaining resources. Cloudrail is capable of understanding all of these scenarios.
2. When the Cloudrail CLI container analyzes your plan, it needs access to some files in the directory where the plan was created. These files are NOT uploaded to our service, and are only used locally for analysis.
3. If the ```--auto-approve``` flag is excluded, the Cloudrail CLI will show you what it's going to upload before it does so. ```--auto-approve``` simply skips that step.
4. If you'd like, you can split the ```run``` into two phases: ```cloudrail generate-context``` which will generate the filtered Terraform context and save it to a file, and then ```cloudrail run``` which will take the filtered context file as input. This allows you to run various data scanning tools before uploading the content to the Cloudrail Service.

# Test Cases to try Cloudrail With
<details>
  <summary>AWS</summary>

  1. [EC2 Classic mode identified](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/disallow_ec2_classic_mode_rule/deploy_redshift_in_ec2_classic_mode)
  2. [Default security group used](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/ensure_all_used_default_security_groups_restrict_all_traffic_rule/default_sg_in_new_vpc)
  3. [Use of the same role for public and private EC2s found](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/ec2_role_share_rule/public_and_private_ec2_same_role)
  5. [The ECS target is exposed publicly on several ports](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/ecs_entity_expose_port_to_public_connections/ecs_schedule_task_expose_port)
  6. [Use of default security group identified](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/ensure_all_used_default_security_groups_restrict_all_traffic_rule/default_sg_in_new_vpc)
  7. [EC2 identified as a potential pivot point in reaching Rds cluster](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/indirect_public_access_db_rds/public_ec2_points_to_private_rds)
  8. [EC2 identified as a potential pivot point in reaching Redshift cluster](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/indirect_public_access_db_redshift/public_ec2_points_to_private_redshift)
  9. [RDS database found to be publicly accessible](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/public_access_db_rds/aurora/vpc-controlled-public)
  10. [Redshift cluster public access identified](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/public_access_db_redshift_rule/redshift_without_public_access)
  11. [Public access to port 22 found](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/public_access_security_groups_port_rule/bastion_server)
  12. [Use of Default VPC identified](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/disallow_default_vpc/deploy_ec2_to_default_vpc)
  13. [Violations found in the runtime variable](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/runtime_variables)
  14. [Violations found in the TF Variables](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/tfvars)
  15. [Use of overlapping CIDR blocks](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/vpcs_in_tgw_no_overlapping_cidr_rule/overlapping_routes)
  16. [Loadbalancers should not use HTTP for target groups](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/alb_disallow_target_groups_http_rule/alb_use_http)
  17. [Cloudfront protocol version should be high](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/cloudfront_distributiion_list/cloudfront_protocol_version_is_low)
  18. [EKS logging should be enabled](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/eks_logging_disable/failure)
  19. [Default Security Groups, when used, shoudl restrict all traffic](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/ensure_all_used_default_security_groups_restrict_all_traffic_rule/ec2_simple_deceleration)
  20. [ES domain is indirectly accessible from public EC2](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/indirect_public_access_es_domain/public_ec2_points_to_private_domain)
  21. [Ensure used routing tables for VPC peering are "least access"](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/over_exposed_vpc_peering/simple_vpc_peering_scenario)
  22. [EKS should not have a publically exposable API](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/public_access_eks_api/eks_with_public_api)
  23. [Loadbalancer should not expose port 22 to the internet](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/public_access_security_groups_port_rule/port_22_allowed_from_internet_to_load_balancer_explicit)
  24. [S3 buckets should not be accessible from the public and cross-account](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/s3_acl_disallow_public_and_cross_account/acl_public_all_authenticated_users_canned)
  25. [VPC Endpoint Gateway should be used for S3 buckets](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/s3_vpce_gateway_not_used_rule/vpc_do_not_have_direct_s3_service_connection)
  26. [Cloudfront distribution should encrypt data in transit](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/test_ensure_cloudfront_distribution_encrypt_in_transit_rule/not_encrypted)
  27. [API Gateway caching should be encrypted](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/non_encrypted_rest_api_cache_enabled)
  28. [No IAM user should be defined](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/iam_no_human_users_role)
  29. [Redshift clusters should be encrypted at rest](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/ensure_redshift_cluster_created_encrypted_rule)
  30. [Enforce the use of VPC Endpoint gateways for DynamoDB for VPCs](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/dynamodb_vpce_gateway_not_used_rule)
  31. [Enforce the use of VPC Endpoint gateways for DynamoDB for Route Tables](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/dynamodb_vpce_gateway_route_table_exposure_rule)
  32. [ALB should user HTTPS and not HTTP](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/ensure_alb_is_using_https)
  33. [DocDB clusters should be set to be encrypted at rest](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/ensure_docdb_clusters_encrypted_rule)
  34. [DynamodDB DAX clusters should be set to be encrypted at rest](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/ensure_dax_clusters_encrypted_rule)
  35. [Elasticsearch domains should be set to be encrypted node-to-node](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/es_encrypt_node_to_node_rule)
  36. [S3 buckets should be encrypted at rest](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/ensure_s3_buckets_encrypted_rule)
  37. [CloudTrail trails being created should be encrypted at rest using KMS](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/ensure_cloudtrail_encryption_kms_rule)
  38. [Athena Workgroup query results should be encrypted at rest using KMS CMK](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/ensure_athena_workgroups_results_encrypted_rule)
  39. [Cloudwatch Log Groups should be encrypted at rest using KMS CMK](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/ensure_cloud_watch_log_groups_encrypted_rule)
  40. [RDS instances should be encrypted at rest](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/ensure_rds_encrypt_at_rest_rule)
  41. [Only private AMIs should be used](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/allow_only_private_amis_rule)
  42. [Codebuild projects should be set to be encrypted at rest with customer-managed CMK](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/ensure_code_build_projects_encrypted_rule)
  43. [SQS queues should be set to be encrypted at rest](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/ensure_sqs_queues_encrypted_at_rest_rule)
  44. [RDS global clusters should be set to be encrypted at rest](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/ensure_rds_encrypt_at_rest_rule)
  45. [EFS file system policy should not use wildcard actions](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/ensure_efs_fs_policy_not_use_wildcard_rule)
  46. [S3 Glacier vault policy should not use wildcard actions](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/ensure_glacier_vault_policy_not_use_wildcard_rule)
  47. [S3 bucket policy should not use wildcard actions](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/ensure_s3_bucket_policy_not_use_wildcard_rule)
  48. [KMS key policy should not use wildcard actions](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/ensure_kms_key_policy_not_use_wildcard_rule)
  49. [Secrets Manager secret policy should not use wildcard actions](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/ensure_secrets_manager_secret_policy_not_use_wildcard)
  50. [CloudWatch Logs destination policy should not use wildcard actions](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/ensure_cloudwatch_log_destination_policy_not_use_wildcard_rule)
  51. [API Gateway endpoint policy should not use wildcard actions](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/ensure_rest_api_gw_policy_not_use_wildcard_rule)
  52. [Elasticsearch Service domain policy should not use wildcard actions](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/ensure_elastic_search_domain_policy_not_use_wildcard_rule)
  53. [Glue data catalog policy should not use wildcard actions](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/ensure_glue_data_catalog_policy_not_use_wildcard_rule)
  54. [S3 bucket objects are set to be encrypted at rest](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/ensure_s3_bucket_objects_encrypted_rule)
  55. [EFS Filesystems should be encrypted at rest](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/ensure_efs_filesystems_encrypted_at_rest_rule)
  56. [All data stored in the S3 bucket should have versioning enabled](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/ensure_s3_buckets_versioning_rule)
  57. [Cloudfront Distribution being created should be set to perform field-level encryption](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/
  58. [Cloudfront Distribution being created should be set to perform field-level encryption](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/ensure_cloudfront_distribution_field_level_encryption_rule)
  59. [Kinesis streams should be set to be encrypted at rest](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/ensure_kinesis_stream_encrypted_at_rest_rule)
  60. [Kinesis Firehose delivery streams should be set to be encrypted at rest](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/ensure_kinesis_firehose_stream_encypted_at_rest_rule)
  61. [X-Ray encryption config should be set to be encrypted at rest with customer-managed CMK](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/ensure_xray_encryption_using_customer_cmk_rule)
  62. [API Gateway should use modern TLS](https://github.com/indeni/cloudrail-demo/tree/master/test/aws/terraform/ensure_api_gw_use_modern_tls_rule)


</details>
