# Changelog
All notable changes to this project will be documented in this file.

## [0.7.82] - (January 19, 2021)
### Added
Non-Context Aware
- [CR-548] Cloudfront Distribution being created should be set to perform field-level encryption
- [CR-708] Kinesis streams should be set to be encrypted at rest
- [CR-746] Kinesis Firehose delivery streams should be set to be encrypted at rest
- [CR-946] X-Ray encryption config should be set to be encrypted at rest with customer-managed CMK
- [CR-1302] API Gateway should use modern TLS

## [0.7.82] - (January 13, 2021)
### Added
Non-Context Aware (2):
- [CR-706] EFS filesystems should be encrypted at rest
- [CR-759] All data stored in the S3 bucket should have versioning enabled

## [0.7.75] - (January 12, 2021)
### Added
Security Improvements (1):
- Prohibit user from accessing API keys from other environments


## [0.7.60] - (January 11, 2021)
### Added
Rule Added:
Non-Context Aware (11):
- [CR-671] RDS global clusters should be set to be encrypted at rest
- [CR-679] EFS file system policy should not use wildcard actions
- [CR-680] S3 Glacier vault policy should not use wildcard actions
- [CR-681] S3 bucket policy should not use wildcard actions
- [CR-683] KMS key policy should not use wildcard actions
- [CR-684] Secrets Manager secret policy should not use wildcard actions
- [CR-685] CloudWatch Logs destination policy should not use wildcard actions
- [CR-686] API Gateway endpoint policy should not use wildcard actions
- [CR-687] Elasticsearch Service domain policy should not use wildcard actions
- [CR-688] Glue data catalog policy should not use wildcard actions
- [CR-697] S3 bucket objects are set to be encrypted at rest

For changes made in previous versions:
- [V0.6](https://github.com/indeni/cloudrail-demo/blob/v0.6/CHANGELOG.md)
- [V0.5](https://github.com/indeni/cloudrail-demo/blob/v0.5/CHANGELOG.md)
- [V0.4](https://github.com/indeni/cloudrail-demo/blob/v0.4/CHANGELOG.md)
- [V0.3](https://github.com/indeni/cloudrail-demo/blob/v0.3/CHANGELOG.md)
- [V0.2](https://github.com/indeni/cloudrail-demo/blob/v0.2/CHANGELOG.md)
- [V0.1](https://github.com/indeni/cloudrail-demo/blob/v0.1/CHANGELOG.md)


