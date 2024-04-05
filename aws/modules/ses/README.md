<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ses_email"></a> [ses\_email](#module\_ses\_email) | ./ses | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloudwatch_destination_event"></a> [cloudwatch\_destination\_event](#input\_cloudwatch\_destination\_event) | Provide the Dimention name and value for cloudwatch destination. | `map(string)` | n/a | yes |
| <a name="input_configuration_set_name"></a> [configuration\_set\_name](#input\_configuration\_set\_name) | Provide the name for Configuration set. | `string` | n/a | yes |
| <a name="input_create_dedicated_ip_pool"></a> [create\_dedicated\_ip\_pool](#input\_create\_dedicated\_ip\_pool) | Should be true if you want to create dedicated ip pool | `bool` | n/a | yes |
| <a name="input_create_receipt_rule"></a> [create\_receipt\_rule](#input\_create\_receipt\_rule) | Should be true if you want to create receipt rule | `bool` | n/a | yes |
| <a name="input_create_receipt_rule_set"></a> [create\_receipt\_rule\_set](#input\_create\_receipt\_rule\_set) | Should be true if you wnat to create receipt rule set. | `bool` | n/a | yes |
| <a name="input_dedicated_ip_pool_name"></a> [dedicated\_ip\_pool\_name](#input\_dedicated\_ip\_pool\_name) | Provide the name for dedicated ip pool | `string` | n/a | yes |
| <a name="input_domain"></a> [domain](#input\_domain) | Provide the domain name to assign to SES | `string` | n/a | yes |
| <a name="input_emails"></a> [emails](#input\_emails) | Emails list to use for SES. | `list(string)` | n/a | yes |
| <a name="input_lambda_invocation_type"></a> [lambda\_invocation\_type](#input\_lambda\_invocation\_type) | Provide the Invocation type to Invoke Lambda function. Allowed values are Event or RequestResponse | `string` | n/a | yes |
| <a name="input_notification_type"></a> [notification\_type](#input\_notification\_type) | The type of notifications that will be published to the specified Amazon SNS topic. Allowed values are Bounce, Complaint or Delivery | `list(string)` | n/a | yes |
| <a name="input_receipt_rule_name"></a> [receipt\_rule\_name](#input\_receipt\_rule\_name) | Provide the name for Receipt rule. | `string` | n/a | yes |
| <a name="input_receipt_rule_set_name"></a> [receipt\_rule\_set\_name](#input\_receipt\_rule\_set\_name) | Provide the name for Receipt rule set | `string` | n/a | yes |
| <a name="input_recipients"></a> [recipients](#input\_recipients) | A list of email addresses | `list(string)` | n/a | yes |
| <a name="input_s3_store_bucket_name"></a> [s3\_store\_bucket\_name](#input\_s3\_store\_bucket\_name) | Provide the nsme of s3 bucket where you want to store emails. | `string` | n/a | yes |
| <a name="input_ses_lambda_function_arn"></a> [ses\_lambda\_function\_arn](#input\_ses\_lambda\_function\_arn) | Provide the ARN of the Lambda function to invoke | `string` | n/a | yes |
| <a name="input_sns_topic_arn"></a> [sns\_topic\_arn](#input\_sns\_topic\_arn) | Provide the SNS Topic arn | `string` | `""` | no |
| <a name="input_tls_policy"></a> [tls\_policy](#input\_tls\_policy) | Whether messages that use the configuration set are required to use Transport Layer Security. The possible values are REQUIRE or OPTIONAL | `string` | n/a | yes |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | Provide the Zone ID of the Route53 Domain. If Route 53 and SES Present in the same account. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->