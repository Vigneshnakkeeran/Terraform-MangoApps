<!-- BEGIN_TF_DOCS -->
## Route53_record on AWS using Terraform Template

- This Terraform template is designed for creating and managing Route 53 records on Amazon Web Services (AWS). AWS Route 53 is a scalable and highly available Domain Name System (DNS) web service that allows you to route traffic to various AWS resources based on DNS records.
- The main.tf, variable.tf, provider.tf, and backend.tf files are typically used in a Terraform project to organize and configure your infrastructure code. 


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
| <a name="module_route53"></a> [route53](#module\_route53) | mango-terraform/aws/modules/route53/records | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_eip.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | Provide the Zone ID of the Route53 Domain. If Route 53 and SES Present in the same account. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
