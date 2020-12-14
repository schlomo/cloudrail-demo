# Changelog
All notable changes to this project will be documented in this file.
## [0.4.70] - (December 10, 2020)
### Added
Rule Added (5):
- [CR-546] CloudTrail trails being created should be encrypted at rest using KMS
- [CR-550] Athena Workgroup query results should be encrypted at rest using KMS CMK
- [CR-595] Cloudwatch Log Groups should be encrypted at rest using KMS CMK
- [CR-665] RDS instances should be encrypted at rest
- [CR-871] Only private AMIs should be used

Platform Enhancements (2):
- Added new JSON output format to support Gitlab integration
- Cloudrail CLI flags can be achieved through single character commands

## [0.4.38] - (December 9, 2020)
### Added
Rule Added (5):
- [CR-384] ALB should use HTTPS and not HTTP
- [CR-615] DocDB clusters should be set to be encrypted at rest
- [CR-622] DynamodDB DAX clusters should be set to be encrypted at rest
- [CR-664] Elasticsearch domains should be set to be encrypted node-to-node
- [CR-673] S3 buckets should be encrypted at rest

Platform Enhancements (1):
- Added additional CLI fields to add context when deployed in CI/CD

## [0.4.23] - (December 4, 2020)
### Added
Rule Added (6):
Harden VPCs with the use of VPC Endpoint gateways for the following services:
- [CR-309] S3
- [CR-598] DynamoDB

- [CR-516] Ensure API Gateway caching is encrypted
- [CR-593] Ensure no human IAM users defined
- [CR-744] Ensure Redshift clusters being created are set to be encrypted at rest

Resources supported for our Context Engine:
- Auto-scaling groups and potential EC2 creations.

Platform Enhancements (1):
- cloudrail will present an exit code for CI/CD services

For changes made in previous versions:
- [V0.3](https://github.com/indeni/cloudrail-demo/blob/v0.3/CHANGELOG.md)
- [V0.2](https://github.com/indeni/cloudrail-demo/blob/v0.2/CHANGELOG.md)
- [V0.1](https://github.com/indeni/cloudrail-demo/blob/v0.1/CHANGELOG.md)
