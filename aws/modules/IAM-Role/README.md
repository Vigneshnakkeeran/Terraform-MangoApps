# IAM Role with Policies Module

This Terraform module creates an AWS IAM role and attaches both a managed policy and a custom policy to it.

## Usage

To use this module in your configuration, follow this example:

```hcl
module "iam_role_with_policies" {
  source                       = "path/to/iam-role-with-policies"
  role_name                    = "example-role-name"
  custom_policy_name           = "example-custom-policy-name"
  custom_policy                = <<EOF
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
  managed_policy_arn           = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}
