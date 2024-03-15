# AWS Lambda Terraform Module

This Terraform module deploys an AWS Lambda function with an execution role and an optional Lambda Layer for shared dependencies. It's designed to simplify the management of AWS Lambda deployments, including necessary permissions and dependencies.

## Prerequisites

- Terraform 0.12.x or later
- AWS provider plugin for Terraform
- An AWS account and configured AWS CLI

## Usage

To use this module in your Terraform configuration, follow these steps:

```hcl
  module "my_lambda_module" {
    source               = "./my-lambda-module"
    lambda_function_name = "my-lambda-function"
    role                 = module.lambda_execution_role.arn
    runtime              = "python3.8"
    handler              = "index.handler"
    memory_size =          ""
    ephemeral_storage_size = ""
  }

output "lambda_function_arn" {
  value = module.lambda_with_layer.lambda_arn
}
```
# Input

| Name | Description | Type |
|----------|----------|----------|
| lambda_function_name |The name of the Lambda function. | string |
| runtime  | The runtime environment for the Lambda function. | string |
| handler |  The function entry point in your code. | string |
| memory_size | Amount of memory in MB your Lambda Function can use at runtime. Defaults to 128 | string |
| ephemeral_storage_size |  The size of the Lambda function Ephemeral storage(/tmp) represented in MB | string | 

# Outputs

| Name | Description |
|----------|----------|
| lambda_arn | The ARN of the deployed Lambda function. |

