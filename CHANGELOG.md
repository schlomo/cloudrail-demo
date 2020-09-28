# Changelog
All notable changes to this project will be documented in this file.
 
## [0.1.213] - (September 28, 2020)
### Added
Rules added (30):
Cloudrail has the following rules built to ensure that workloads exposable to the internet are not exposing the following network traffic:
- [CR-108] All Ports
- [CR-100] Port 27018 (MongoDB)
- [CR-101] Port 7199 (Cassandra)
- [CR-102] Port 9160 (Cassandra)
- [CR-103] Port 8888 (Cassandra)
- [CR-104] Port 11211 (Memcached)
- [CR-105] Port 9300 (Elasticsearch)
- [CR-106] Port 9200 (Elasticsearch)
- [CR-107] Port 5601 (Kibana)
- [CR-80] Port 22 (SSH)
- [CR-93] Port 3389 (Microsoft RDP)
- [CR-94] Port 1521 (Oracle DB)
- [CR-95] Port 2483 (Oracle DB)
- [CR-96] Port 3306 (MySQL)
- [CR-97] Port 5432 (Postgres)
- [CR-98] Port 6379 (Redis)
- [CR-99] Port 27017 (MongoDB)
 
Cloudrail can also identify the following security concerns in your environment:
- [CR-220] Redshift cluster is publically accessible.
- [CR-221] Redshift instance is indirectly accessible to the public from a public resource.
- [CR-224] RDS database is exposed to the internet.
- [CR-225] RDS instance is exposed indirectly through a publically accessible resource.
- [CR-227] Elasticsearch Domain is exposed to the internet.
- [CR-228] Elasticsearch Domain is exposed indirectly through a publically accessible resource.
- [CR-298] Resources being deployed within the default VPC.
- [CR-239] Ensure that EC2 Classic mode is not used.
- [IS-4976] Public and private EC2 workloads are utilizing the same IAM role.
- [CR-29] VPCs utilizing overlapping CIDR blocks within the Transit Gateway.
- [CR-229] Ensure that route tables used within VPC Peers are "least access" by analyzing subnets.
- [CR-177] Ensure the default security group of every VPC restricts all traffic.
 
Resources supported for our Context Engine:
AWS (27):
- VPC
- Network Subnet
- Security Groups
- Network ACLs
- Main Route Tables
- Route Table in-line routes
- Internet Gateway
- Auto-scaling Group
- VPC Peering Connection
- Transit Gateway
- Elastic Container Service
- Elastic Load Balancing
- Elastic Network Interfaces
- RDS
- EC2
- ECS
- Elasticsearch
- Redshift
- S3 Bucket
- S3 Bucket Policy
- S3 Bucket ACL
- IAM User
- IAM Group
- IAM in-line policies
- IAM Role
- IAM Customer-managed Policy
- IAM Managed Policy
 
 
Platform Enhancements (2):
- Compatibility with Terraform v0.13 and v0.12
- Ability to combine data from Terraform and AWS