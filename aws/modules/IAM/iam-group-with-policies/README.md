# IAM group with policies example

Configuration in this directory creates IAM group with users who has specified IAM policies.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.20 |

## Providers

| Name | Version |
w
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.20 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_iam_user"></a> [iam\_user](#module\_iam\_user) | mango-terraform/aws/modules/IAM/iam-user | n/a |
| <a name="module_iam_group_with_custom_policies"></a> [iam\_group\_with\_custom\_policies](#module\_iam\_group\_with\_custom\_policies) | mango-terraform/aws/modules/IAM/iam-group-with-policies | n/a |


## Resources

| Name | Type |
|------|------|
| [aws_iam_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group) | resource |
| [aws_iam_group_membership.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_membership) | resource |
| [aws_iam_group_policy_attachment.custom_arns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policy_attachment) | resource |
| [aws_iam_policy.custom](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_group_arn"></a> [group\_arn](#output\_group\_arn) | IAM group arn |
| <a name="output_group_name"></a> [group\_name](#output\_group\_name) | IAM group name |
| <a name="output_group_users"></a> [group\_users](#output\_group\_users) | List of IAM users in IAM group |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
