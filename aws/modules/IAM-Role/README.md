# IAM Role with Policies Module

This Terraform module creates an AWS IAM role and attaches both a managed policy and a custom policy to it.

## Usage

To use this module in your configuration, follow this example:

```hcl
module "iam_role_with_policies" {
  source                       = "path/to/iam-role-with-policies"
  role_name           = "example-role"
  assume_role_policy  = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
  managed_policy_arns = ["arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"]
  custom_policy_name  = "example-custom-policy"
  custom_policy       = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "logs:CreateLogGroup",
      "Resource": "*"
    }
  ]
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

