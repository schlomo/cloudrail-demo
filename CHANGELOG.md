# Changelog
All notable changes to this project will be documented in this file.
## [0.4.23] - (December 4, 2020)
### Added
Rule Added (6):
Harden VPCs with the use of VPC Endpoint gateways for the following services:
- [CR-309] S3
- [CR-598] DynamoDB for Route Tables

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