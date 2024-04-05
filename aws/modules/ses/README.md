<!-- BEGIN_TF_DOCS -->
## SES Configuration on AWS using Terraform Template

This Terraform template is designed for creating and managing AWS SES (Simple Email Service).
If module is provided with Route53 Zone ID it can also create verification DNS records for domain and DKIM.


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
| <a name="module_ses"></a> [ses](#module\_ses) | mango-terraform/aws/modules/ses | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_route53_record.amazonses_dkim_record](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.custom_mail_from_mx](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_ses_domain_dkim.ses_domain_dkim](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ses_domain_dkim) | resource |
| [aws_ses_domain_identity.ses_domain](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ses_domain_identity) | resource |
| [aws_ses_domain_mail_from.custom_mail_from](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ses_domain_mail_from) | resource |
| [aws_ses_receipt_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ses_receipt_rule) | resource |
| [aws_ses_active_receipt_rule_set](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ses_active_receipt_rule_set) | resource |
| [aws_sesv2_dedicated_ip_pool](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sesv2_dedicated_ip_pool) | resource |
| [aws_ses_identity_notification_topic](https://registry.terraform.io/providers/hashicorp/aws/3.74.3/docs/resources/ses_identity_notification_topic) | resource |

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
