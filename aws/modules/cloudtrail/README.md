## AWS Cloudtrail using Terraform

Terraform module to provision an AWS CloudTrail. The module accepts an encrypted S3 bucket with versioning to store CloudTrail logs. The bucket could be from the same AWS account or from a different account.

## Usage

```shell
module "cloudtrail" {
  source = "path/of/module"
  name                          = "cluster"
  enable_log_file_validation    = true
  include_global_service_events = true
  is_multi_region_trail         = false
  enable_logging                = true
  s3_bucket_name                = "my-cloudtrail-logs-bucket"
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
| <a name="module_cloudtrail"></a> [cloudtrail](#module\_cloudtrail) | mangoapps/aws/modules/cloudtrail | n/a |


## Resources

| Name | Type |
|------|------|
| [aws_cloudtrail.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudtrail) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_enable_cloudtrail"></a> [enable\_cloudtrail](#input\_enable\_cloudtrail) | Enables Cloudtrail. | `bool` | n/a | yes |
| <a name="input_enable_log_file_validation"></a> [enable\_log\_file\_validation](#input\_enable\_log\_file\_validation) | Specifies whether log file integrity validation is enabled. Creates signed digest for validated contents of logs | `bool` | n/a | yes |
| <a name="input_enable_logging"></a> [enable\_logging](#input\_enable\_logging) | Enable logging for the cloudtrail | `bool` | n/a | yes |
| <a name="input_include_global_service_events"></a> [include\_global\_service\_events](#input\_include\_global\_service\_events) | Specifies whether the trail is publishing events from global services such as IAM to the log files | `bool` | n/a | yes |
| <a name="input_is_multi_region_trail"></a> [is\_multi\_region\_trail](#input\_is\_multi\_region\_trail) | Specifies whether the trail is created in the current region or in all regions | `bool` | n/a | yes |
| <a name="input_is_organization_trail"></a> [is\_organization\_trail](#input\_is\_organization\_trail) | The trail is an AWS Organizations trail | `bool` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloudtrail_arn"></a> [cloudtrail\_arn](#output\_cloudtrail\_arn) | The Amazon Resource Name of the trail |
| <a name="output_cloudtrail_id"></a> [cloudtrail\_id](#output\_cloudtrail\_id) | The name of the trail |