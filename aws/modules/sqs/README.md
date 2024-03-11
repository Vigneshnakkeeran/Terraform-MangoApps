<!-- BEGIN_TF_DOCS -->
## SQS Configuration on AWS using Terraform Template

This Terraform template is designed for creating and managing AWS SQS on Amazon Web Services (AWS).


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
| <a name="module_sqs"></a> [sqs](#module\_sqs) | mango-terraform/aws/modules/sqs | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_sqs_queue.dlq](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue) | resource |
| [aws_sqs_queue.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue) | resource |
| [aws_sqs_queue_policy.dlq](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue_policy) | resource |
| [aws_sqs_queue_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue_policy) | resource |
| [aws_sqs_queue_redrive_policy.dlq](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue_redrive_policy) | resource |
| [aws_sqs_queue_redrive_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue_redrive_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_sqs"></a> [create\_sqs](#input\_create\_sqs) | Whether to create SQS or not. | `bool` | n/a | yes |
| <a name="input_enable_content_based_deduplication"></a> [enable\_content\_based\_deduplication](#input\_enable\_content\_based\_deduplication) | Should be true to enables content-based deduplication for FIFO queues. to enable this fifo queue should be true. | `bool` | n/a | yes |
| <a name="input_max_message_size"></a> [max\_message\_size](#input\_max\_message\_size) | The limit of how many bytes a message can contain before Amazon SQS rejects it. An integer from 1024 bytes (1 KiB) up to 262144 bytes (256 KiB) | `number` | n/a | yes |
| <a name="input_message_retention_seconds"></a> [message\_retention\_seconds](#input\_message\_retention\_seconds) | The number of seconds Amazon SQS retains a message. Integer representing seconds, from 60 (1 minute) to 1209600 (14 days) default valu is 4days | `number` | n/a | yes |
| <a name="input_sqs_create_dlq"></a> [sqs\_create\_dlq](#input\_sqs\_create\_dlq) | Should be true if you want to create SQS dead letter queue | `bool` | n/a | yes |
| <a name="input_sqs_create_fifo_queue"></a> [sqs\_create\_fifo\_queue](#input\_sqs\_create\_fifo\_queue) | Should be true if you want to create fifo queue | `bool` | n/a | yes |
| <a name="input_sqs_sse_enabled"></a> [sqs\_sse\_enabled](#input\_sqs\_sse\_enabled) | Should be true if you want to enable server side encription | `bool` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dead_letter_queue_arn"></a> [dead\_letter\_queue\_arn](#output\_dead\_letter\_queue\_arn) | The ARN of the SQS queue |
| <a name="output_dead_letter_queue_id"></a> [dead\_letter\_queue\_id](#output\_dead\_letter\_queue\_id) | The URL for the created Amazon SQS queue |
| <a name="output_dead_letter_queue_name"></a> [dead\_letter\_queue\_name](#output\_dead\_letter\_queue\_name) | The name of the SQS queue |
| <a name="output_dead_letter_queue_url"></a> [dead\_letter\_queue\_url](#output\_dead\_letter\_queue\_url) | Same as `dead_letter_queue_id`: The URL for the created Amazon SQS queue |
| <a name="output_queue_arn"></a> [queue\_arn](#output\_queue\_arn) | The ARN of the SQS queue |
| <a name="output_queue_id"></a> [queue\_id](#output\_queue\_id) | The URL for the created Amazon SQS queue |
| <a name="output_queue_name"></a> [queue\_name](#output\_queue\_name) | The name of the SQS queue |
| <a name="output_queue_url"></a> [queue\_url](#output\_queue\_url) | Same as `queue_id`: The URL for the created Amazon SQS queue |
<!-- END_TF_DOCS -->
