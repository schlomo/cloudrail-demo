# Changelog
All notable changes to this project will be documented in this file.
## [0.2.387] - (November 16, 2020)
### Added
Rule Added (:
- [CR-544] Ensure Cloudfront Distribution should be set to perform encyrption in transit

Resources supported for our Context Engine: AWS (2)
- ALB (Context of ALB Subnets mapped to the ALB)
- LB listener ports

Platform Enhancements :
- Cloudrail CLI is now available as a container for use within CI/CD
- Provide human readable text for the business logic used in each rule

## [0.2.329] - (November 12, 2020)
### Added
Rule Added (3):
- Identify if S3 buckets are not made widely accessible through ACLs and Buck Policies
- Ensure IAM permissions are not given directly to users
- [CR-469] Ensure Cloudfront Protocol version is a good one.

Platform Enhancements (1):
- Support for Terraform v0.14

## [0.2.317] - (November 2, 2020)
### Added
Rule Added (1):
- Identify if an LB target group is relying on HTTP

## [0.2.315] - (November 2, 2020)
### Added
Platform Enhancements (1):
- Support to output cloudrail's results in junit.xml

## [0.2.312] - (November 1, 2020)
### Added
Rule Added (1):
- [CR-271] Identify publically accessible EKS APIs

Resources supported for our Context Engine: AWS (1)
- EKS

Platform Enhancements (4):
- Support for AWS Provider v3.9.0, v3.10.0, v3.11.0, v3.12.0, v3.13.0
- Introduce junit support for Cloudrail's evaluation results.
- Shortened Cloudrail’s evaluation step’s running time by 50%
- Updated Cloudrail’s Evidence field to better showcase Cloudrail’s Context
![Alt text](https://github.com/indeni/cloudrail-demo/blob/v0.2/docs/images/Cloudrail-evidence.png)
- Added Terraform file reference to each violation:
![Alt text](https://github.com/indeni/cloudrail-demo/blob/v0.2/docs/images/tf-line-reference.png)

For changes made in previous versions:
- [V0.1](https://github.com/indeni/cloudrail-demo/blob/v0.1/CHANGELOG.md)
