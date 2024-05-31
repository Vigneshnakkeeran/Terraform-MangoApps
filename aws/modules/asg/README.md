## ASG Configuration on AWS using Terraform Template


- This Terraform template is designed for creating and managing AutoScaling Group (ASG) configuration on Amazon Web Services (AWS).

## Available Features

- Autoscaling group with launch template - either created by the module or utilizing an existing launch template
- Autoscaling group utilizing mixed instances policy
- Ability to configure autoscaling groups to set instance refresh configuration and add lifecycle hooks
- Ability to create an autoscaling group that respects `desired_capacity` or one that ignores to allow for scaling without conflicting Terraform diffs
- IAM role and instance profile creation

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.20 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.20 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_asg"></a> [asg](#module\_asg) | mangoapps/aws/modules/asg | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_autoscaling_group.idc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group) | resource |
| [aws_autoscaling_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group) | resource |
| [aws_autoscaling_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_policy) | resource |
| [aws_autoscaling_schedule.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_schedule) | resource |
| [aws_autoscaling_traffic_source_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_traffic_source_attachment) | resource |
| [aws_iam_instance_profile.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource || [aws_launch_template.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template) | resource |
| [aws_iam_policy_document.assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_asg_ami_id"></a> [asg\_ami\_id](#input\_asg\_ami\_id) | AMI ID for the ASG Launch Template | `string` | n/a | yes |
| <a name="input_asg_desired_size"></a> [asg\_desired\_size](#input\_asg\_desired\_size) | Desired Size for the ASG | `number` | n/a | yes |
| <a name="input_asg_instance_ebs_optimized"></a> [asg\_instance\_ebs\_optimized](#input\_asg\_instance\_ebs\_optimized) | If enabled, the instances launched by the ASG will be EBS optimized | `bool` | n/a | yes |
| <a name="input_asg_instance_type"></a> [asg\_instance\_type](#input\_asg\_instance\_type) | Instance type for the ASG Launch Template | `string` | n/a | yes |
| <a name="input_asg_key_name"></a> [asg\_key\_name](#input\_asg\_key\_name) | Key Pair used for SSH to ASG instances | `string` | n/a | yes |
| <a name="input_asg_max_size"></a> [asg\_max\_size](#input\_asg\_max\_size) | Maximum Size for the ASG | `number` | n/a | yes |
| <a name="input_asg_min_size"></a> [asg\_min\_size](#input\_asg\_min\_size) | Minimum Size for the ASG | `number` | n/a | yes |
| <a name="input_asg_volume_mapping"></a> [asg\_volume\_mapping](#input\_asg\_volume\_mapping) | EBS Volume mappings for ASG | `list(any)` | n/a | yes |
| <a name="input_create_asg_iam_instance_profile"></a> [create\_asg\_iam\_instance\_profile](#input\_create\_asg\_iam\_instance\_profile) | If enabled, creates instance profiles for the instances launched by the ASG | `bool` | n/a | yes |
| <a name="input_enable_asg_monitoring"></a> [enable\_asg\_monitoring](#input\_enable\_asg\_monitoring) | Enables monitoring for the ASG | `bool` | n/a | yes |
| <a name="input_warm_pool"></a> [warm\_pool](#input\_warm\_pool) | If this block is configured, add a Warm Pool to the specified Auto Scaling group | `any` | `{}` | no |
| <a name="input_scaling_policies"></a> [scaling\_policies](#input\_scaling\_policies) | Map of target scaling policy schedule to create | `any` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_autoscaling_group_arn"></a> [autoscaling\_group\_arn](#output\_autoscaling\_group\_arn) | The ARN for this AutoScaling Group |
| <a name="output_autoscaling_group_id"></a> [autoscaling\_group\_id](#output\_autoscaling\_group\_id) | The autoscaling group id |
| <a name="output_autoscaling_group_name"></a> [autoscaling\_group\_name](#output\_autoscaling\_group\_name) | The autoscaling group name |
