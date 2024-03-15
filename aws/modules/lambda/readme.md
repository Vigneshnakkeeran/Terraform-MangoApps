# IAM Role with Policies Module

This Terraform module creates an AWS IAM role and attaches both a managed policy and a custom policy to it.

## Usage

To use this module in your configuration, follow this example:

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
EOF
}
```

# Input

| Name | Description | Type |
|----------|----------|----------|
| role_name | The name of the IAM role. | string |
| custom_policy_name | The name of the custom policy. | string |
| custom_policy | The JSON policy document. | string |
| managed_policy_arn | The ARN of the aws managed policy to attach | string | 

# Outputs

| Name | Description |
|----------|----------|
| iam_role_arn | The ARN of the IAM role. |
| custom_policy_name | The name of the custom policy attached to the IAM role. |
