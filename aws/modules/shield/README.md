## AWS Shield protection using Terraform

Terraform module for enabling shield protection for specific AWS resources. Resource can be an Amazon CloudFront distribution, Elastic Load Balancing load balancer, AWS Global Accelerator accelerator, Elastic IP Address, or an Amazon Route 53 hosted zone.

## Usage

```shell
module "aws_shield" {
  source = "path/of/module"

  name = "test-shield"
  associated_arns = ["${var.cloudfront_arn}", "${var.alb_arn}"]
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
| <a name="module_aws_shield"></a> [aws\_shield](#module\_aws\_shield) | mangoapps/aws/modules/shield | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_shield_protection.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/shield_protection) | resource |

## Inputs


| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | Shield Name. | `string` | `""` | no |
| <a name="input_associated_arns"></a> [associated\_arns](#input\_associated\_arns) | List of ARNs to which AWS Shield is associated to. | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to resources | `map(string)` | `{}` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_shield_arn"></a> [shield\_arn](#output\_shield\_arn) | Shield ARNs |
| <a name="output_shield_id"></a> [shield\_id](#output\_shield\_id) | Shield IDs |