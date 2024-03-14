<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.20 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.40.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_alb_security_group"></a> [alb\_security\_group](#module\_alb\_security\_group) | ../../../modules/security-group | n/a |
| <a name="module_bastion_security_group"></a> [bastion\_security\_group](#module\_bastion\_security\_group) | ../../../modules/security-group | n/a |
| <a name="module_alb"></a> [lb](#module\_alb) | ../../../modules/alb | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_acm_certificate.mangoapp_cert](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/acm_certificate) | data source |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acl"></a> [acl](#input\_acl) | (Optional) The canned ACL to apply. Conflicts with `grant` | `string` | n/a | yes |
| <a name="input_alb_certificate_domain_name"></a> [alb\_certificate\_domain\_name](#input\_alb\_certificate\_domain\_name) | Provide The alb Certificate Domain name present in ACM with Issued status. | `string` | n/a | yes |
| <a name="input_alb_egress_with_cidr_blocks"></a> [alb\_egress\_with\_cidr\_blocks](#input\_alb\_egress\_with\_cidr\_blocks) | List of egress rules to create by name | `list(map(string))` | n/a | yes |
| <a name="input_alb_ingress_with_cidr_blocks"></a> [alb\_ingress\_with\_cidr\_blocks](#input\_alb\_ingress\_with\_cidr\_blocks) | List of ingress rules to create where 'cidr\_blocks' is used | `list(map(string))` | n/a | yes |
| <a name="input_alb_name"></a> [alb\_name](#input\_alb\_name) | Provide The name for ALB. This name must be unique within your AWS account, can have a maximum of 32 characters, must contain only alphanumeric characters or hyphens, and must not begin or end with a hyphen | `string` | n/a | yes |
| <a name="input_alb_sg_description"></a> [alb\_sg\_description](#input\_alb\_sg\_description) | Security Group for ALB | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
