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

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.66 |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
