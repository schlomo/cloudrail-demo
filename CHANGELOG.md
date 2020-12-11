# Changelog
All notable changes to this project will be documented in this file.
## [0.3.28] - (November 24, 2020)
### Added
Rule Added (3):
- [CR-309] Enforce the use of VPC Endpoint Gateways for S3s in VPCs
- [CR-495] IMDSv2 should be used and IMDSv1 should be disabled.
- [CR-543] Athena Workgroup query results should be configured to be encrypted at rest

Resources supported for our Context Engine:
- Auto-scaling groups and potential EC2 creations.
- Support for ECS service as a potential LB target

Platform Enhancements (2):
- Evaluation results in the CLI can be formatted with JSON using the flag "--output json"
- Introduce Severity and Categories to all the rules

For changes made in previous versions:
- [V0.2](https://github.com/indeni/cloudrail-demo/blob/v0.2/CHANGELOG.md)
- [V0.1](https://github.com/indeni/cloudrail-demo/blob/v0.1/CHANGELOG.md)
