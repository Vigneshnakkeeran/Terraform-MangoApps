# AWS Systems Manager Terraform Configuration

This Terraform configuration manages various AWS Systems Manager resources including parameters, automation documents, maintenance windows, and associated tasks and roles. It is designed to facilitate automation and management of resources within AWS environments.

## Prerequisites

- **AWS Account:** You need to have an AWS account. Sign up [here](https://aws.amazon.com/) if you don't have one.
- **Terraform:** Install Terraform. You can download it from [here](https://www.terraform.io/downloads.html).
- **AWS CLI:** Install and configure the AWS CLI. Instructions can be found [here](https://aws.amazon.com/cli/).

## Resources Managed

1. **SSM Parameters:** Configuration for storing secure strings, strings, and other data types securely in SSM.
2. **SSM Document:** Defines automation documents for AWS Systems Manager.
3. **Maintenance Window:** Schedules maintenance windows for managed instances.
4. **Maintenance Window Task:** Associates tasks with a specific maintenance window.
5. **IAM Role and Policy:** Permissions for the Systems Manager to perform tasks during the maintenance window.
