<!-- BEGIN_TF_DOCS -->
## SNS Configuration on AWS using Terraform Template

This Terraform template is designed for creating and managing AWS SNS (Simple Notification Service) topic with email subscriptions and SQS subscription.


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
| <a name="module_sns"></a> [sns](#module\_sns) | mango-terraform/aws/modules/sns | n/a |
| <a name="module_sns_email_subscription"></a> [sns\_email\_subscription](#module\_sns\_email\_subscription) | mango-terraform/aws/modules/sns/sns-subscription | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_sns_topic.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |
| [aws_sns_topic_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_policy) | resource |
| [aws_sns_topic_subscription.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_sns_email_subscriptions"></a> [sns\_email\_subscriptions](#input\_sns\_email\_subscriptions) | A map of subscription definitions to create email subscription | `any` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_subscriptions"></a> [subscriptions](#output\_subscriptions) | Map of subscriptions created and their attributes |
| <a name="output_topic_arn"></a> [topic\_arn](#output\_topic\_arn) | The ARN of the SNS topic, as a more obvious property (clone of id) |
| <a name="output_topic_name"></a> [topic\_name](#output\_topic\_name) | The name of the topic |
<!-- END_TF_DOCS -->
