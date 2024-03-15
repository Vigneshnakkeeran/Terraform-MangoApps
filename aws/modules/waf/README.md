## WAF Configuration on AWS using Terraform Template

- This Terraform template is used to create and manage AWS WAFv2 rules on Amazon Web Services (AWS).

## Usage

```shell
module "cloudfront_wafv2_web_acl" {
  source          = "path/of/module"
  create_wafv2    = true
  web_acl_name    = "test-cloudfront-web-acl"
  waf_description = "Test Cloudfront WAF"
  scope           = "CLOUDFRONT"

  visibility_config = {
      cloudwatch_metrics_enabled = true
      metric_name                = "mangoapps-rules-metric"
      sampled_requests_enabled   = true
    }

  # List of AWS managed WAF rule configurations
  managed_rule_group_statement_rules = [
    {
      name     = "AWS-AWSManagedRulesAmazonIpReputationList"
      priority = 2

      statement = {
        name        = "AWSManagedRulesAmazonIpReputationList"
        vendor_name = "AWS"
      }

      visibility_config = {
        cloudwatch_metrics_enabled = true
        sampled_requests_enabled   = true
        metric_name                = "AWS-AWSManagedRulesAmazonIpReputationList"
      }
    }
  ]
  
  tags = {
    Created_by  = "Terraform"
  }
}
```

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
| <a name="module_waf"></a> [waf](#module\_waf) | mangoapps/aws/modules/waf | n/a |


## Resources


| Name | Type |
|------|------|
| [aws_wafv2_ip_set.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group) | resource |
| [aws_wafv2_web_acl_logging_configuration.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group) | resource |
| [aws_wafv2_web_acl_association.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_policy) | resource |
| [aws_wafv2_web_acl.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_schedule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_association_resource_arns"></a> [association\_resource\_arns](#input\_association\_resource\_arns) | Provide list of arn's to associate with | `list(string)` | `[]` | no |
| <a name="input_byte_match_statement_rules"></a> [byte\_match\_statement\_rules](#input\_byte\_match\_statement\_rules) | A rule statement that defines a string match search for AWS WAF to apply to web requests. | `list(object())` | `null` | no |
| <a name="input_create_wafv2"></a> [create\_wafv2](#input\_create\_wafv2) | Choose whether the waf should be created or not | `bool` | `false` | no |
| <a name="input_custom_response_body"></a> [custom\_response\_body](#input\_custom\_response\_body) | Defines custom response bodies that can be referenced by custom\_response actions. | <pre>map(object({<br>    content      = string<br>    content_type = string<br>  }))</pre> | `{}` | no |
| <a name="input_default_action"></a> [default\_action](#input\_default\_action) | Specifies that AWS WAF should allow requests by default. Possible values: `allow`, `block`. | `string` | `"block"` | no |
| <a name="input_default_block_response"></a> [default\_block\_response](#input\_default\_block\_response) | A HTTP response code that is sent when default block action is used. Only takes effect if default\_action is set to `block`. | `string` | `null` | no |
| <a name="input_geo_allowlist_statement_rules"></a> [geo\_allowlist\_statement\_rules](#input\_geo\_allowlist\_statement\_rules) | A rule statement used to identify a list of allowed countries which should not be blocked by the WAF. | `list(object())` | `null` | no |
| <a name="input_geo_match_statement_rules"></a> [geo\_match\_statement\_rules](#input\_geo\_match\_statement\_rules) | A rule statement used to identify web requests based on country of origin. | `list(object())` | `null` | no |
| <a name="input_ip_set_reference_statement_rules"></a> [ip\_set\_reference\_statement\_rules](#input\_ip\_set\_reference\_statement\_rules) | A rule statement used to detect web requests coming from particular IP addresses or address ranges. | `list(object())` | `null` | no |
| <a name="input_ipset_name"></a> [ipset\_name](#input\_ipset\_name) | Provide name for ipset | `string` | `""` | no |
| <a name="input_log_destination_configs"></a> [log\_destination\_configs](#input\_log\_destination\_configs) | The Amazon Kinesis Data Firehose, CloudWatch Log log group, or S3 bucket Amazon Resource Names (ARNs) that you want to associate with the web ACL | `list(string)` | `[]` | no |
| <a name="input_logging_filter"></a> [logging\_filter](#input\_logging\_filter) | A configuration block that specifies which web requests are kept in the logs and which are dropped.<br>You can filter on the rule action and on the web request labels that were applied by matching rules during web ACL evaluation. | <pre>object({<br>    default_behavior = string<br>    filter = list(object({<br>      behavior    = string<br>      requirement = string<br>      condition = list(object({<br>        action_condition = optional(object({<br>          action = string<br>        }), null)<br>        label_name_condition = optional(object({<br>          label_name = string<br>        }), null)<br>      }))<br>    }))<br>  })</pre> | `null` | no |
| <a name="input_managed_rule_group_statement_rules"></a> [managed\_rule\_group\_statement\_rules](#input\_managed\_rule\_group\_statement\_rules) | A rule statement used to run the rules that are defined in a managed rule group. | `list(object())` | `null` | no |
| <a name="input_rate_based_statement_rules"></a> [rate\_based\_statement\_rules](#input\_rate\_based\_statement\_rules) | A rate-based rule tracks the rate of requests for each originating IP address,and triggers the rule action when the rate exceeds a limit that you specify on the number of requests in any 5-minute time span. | `list(object())` | `null` | no |
| <a name="input_redacted_fields"></a> [redacted\_fields](#input\_redacted\_fields) | The parts of the request that you want to keep out of the logs. | <pre>map(object({<br>    method        = optional(bool, false)<br>    uri_path      = optional(bool, false)<br>    query_string  = optional(bool, false)<br>    single_header = optional(list(string), null)<br>  }))</pre> | `{}` | no |
| <a name="input_regex_match_statement_rules"></a> [regex\_match\_statement\_rules](#input\_regex\_match\_statement\_rules) | A rule statement used to search web request components for a match against a single regular expression. | `list(object())` | `null` | no |
| <a name="input_regex_pattern_set_reference_statement_rules"></a> [regex\_pattern\_set\_reference\_statement\_rules](#input\_regex\_pattern\_set\_reference\_statement\_rules) | A rule statement used to search web request components for matches with regular expressions. | `list(object())` | `null` | no |
| <a name="input_rule_group_reference_statement_rules"></a> [rule\_group\_reference\_statement\_rules](#input\_rule\_group\_reference\_statement\_rules) | A rule statement used to run the rules that are defined in an WAFv2 Rule Group. | `list(object())` | `null` | no |
| <a name="input_scope"></a> [scope](#input\_scope) | Specifies whether this is for an AWS CloudFront distribution or for a regional application.<br>Possible values are `CLOUDFRONT` or `REGIONAL`.<br>To work with CloudFront, you must also specify the region us-east-1 (N. Virginia) on the AWS provider. | `string` | `"REGIONAL"` | no |
| <a name="input_size_constraint_statement_rules"></a> [size\_constraint\_statement\_rules](#input\_size\_constraint\_statement\_rules) | A rule statement that uses a comparison operator to compare a number of bytes against the size of a request component. | `list(object())` | `null` | no |
| <a name="input_sqli_match_statement_rules"></a> [sqli\_match\_statement\_rules](#input\_sqli\_match\_statement\_rules) | An SQL injection match condition identifies the part of web requests, such as the URI or the query string, that you want AWS WAF to inspect. | `list(object())` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | provide tags for the resource | `map(string)` | `{}` | no |
| <a name="input_token_domains"></a> [token\_domains](#input\_token\_domains) | Specifies the domains that AWS WAF should accept in a web request token. | `list(string)` | `null` | no |
| <a name="input_visibility_config"></a> [visibility\_config](#input\_visibility\_config) | Defines and enables Amazon CloudWatch metrics and web request sample collection. | <pre>object({<br>    cloudwatch_metrics_enabled = bool<br>    metric_name                = string<br>    sampled_requests_enabled   = bool<br>  })</pre> | <pre>{<br>  "cloudwatch_metrics_enabled": false,<br>  "metric_name": "default_metric",<br>  "sampled_requests_enabled": false<br>}</pre> | no |
| <a name="input_waf_description"></a> [waf\_description](#input\_waf\_description) | A friendly description of the WebACL. | `string` | `"Managed by Terraform"` | no |
| <a name="input_web_acl_name"></a> [web\_acl\_name](#input\_web\_acl\_name) | Provide a name for waf | `string` | `""` | no |
| <a name="input_xss_match_statement_rules"></a> [xss\_match\_statement\_rules](#input\_xss\_match\_statement\_rules) | A rule statement that defines a cross-site scripting (XSS) match search for AWS WAF to apply to web requests. | `list(object())` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_waf_arn"></a> [waf\_arn](#output\_cloudfront\_waf\_arn) | WAF ARN |
| <a name="output_waf_id"></a> [waf\_id](#output\_cloudfront\_waf\_id) | WAF ID |