# Changelog
All notable changes to this project will be documented in this file.

## [0.2.317] - (November 2, 2020)
### Added
Rule Added (1)
- Identify if an LB target group is relying on HTTP

## [0.2.315] - (November 2, 2020)
### Added
Platform Enhancements (1):
- Support to output cloudrail's results in junit.xml

## [0.2.312] - (November 1, 2020)
### Added
Rule Added (1)
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
