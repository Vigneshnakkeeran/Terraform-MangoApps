<!-- BEGIN_TF_DOCS -->
## Create Elastic LoadBalancer using Terraform Template.
- This Terraform template is designed for creating and managing Elastic Loadbalancer on Amazon Web Services (AWS). This template allows you to create ALB, NLB, Listners and Target Groups.
- This template offers flexibility in configuring LB attributes such as name, accessibility (internal or external), associated subnets, security groups, and tags.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.20 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.20 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_alb"></a> [lb](#module\_alb) | mango-terraform/aws/modules/elb | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | mango-terraform/aws/modules/network | n/a |
| <a name="module_alb_security_group"></a> [alb\_security\_group](#module\_alb\_security\_group) | mango-terraform/aws/modules/security-group | n/a |



## Resources

| Name | Type |
|------|------|
| [aws_lb.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb_listener.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_listener_certificate.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_certificate) | resource |
| [aws_lb_listener_rule.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_rule) | resource |
| [aws_lb_target_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_lb_target_group_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group_attachment) | resource |


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alb_certificate_domain_name"></a> [alb\_certificate\_domain\_name](#input\_alb\_certificate\_domain\_name) | Provide The alb Certificate Domain name present in ACM with Issued status. | `string` | n/a | yes |
| <a name="input_create"></a> [create](#input\_create) | Controls if resources should be created (affects nearly all resources) | `bool` | `true` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | Identifier of the VPC where the security group will be created | `string` | `null` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | A list of subnet IDs to attach to the LB. Subnets cannot be updated for Load Balancers of type `network`. Changing this value for load balancers of type `network` will force a recreation of the resource | `list(string)` | `null` | no |
| <a name="input_internal"></a> [internal](#input\_internal) | If true, the LB will be internal. Defaults to `false` | `bool` | `null` | no |
| <a name="input_ip_address_type"></a> [ip\_address\_type](#input\_ip\_address\_type) | The type of IP addresses used by the subnets for your load balancer. The possible values are `ipv4` and `dualstack` | `string` | `null` | no |
| <a name="input_listeners"></a> [listeners](#input\_listeners) | Map of listener configurations to create | `any` | `{}` | no |
| <a name="input_load_balancer_type"></a> [load\_balancer\_type](#input\_load\_balancer\_type) | The type of load balancer to create. Possible values are `application`, `gateway`, or `network`. The default value is `application` | `string` | `"application"` | no |
| <a name="input_enable_deletion_protection"></a> [enable\_deletion\_protection](#input\_enable\_deletion\_protection) | If `true`, deletion of the load balancer will be disabled via the AWS API. This will prevent Terraform from deleting the load balancer. | `bool` | `true` | no |
| <a name="input_enable_cross_zone_load_balancing"></a> [enable\_cross\_zone\_load\_balancing](#input\_enable\_cross\_zone\_load\_balancing) | If `true`, cross-zone load balancing of the load balancer will be enabled. For application load balancer this feature is always enabled (`true`) and cannot be disabled. Defaults to `true` | `bool` | `true` | no |
| <a name="input_target_groups"></a> [target\_groups](#input\_target\_groups) | Map of target group configurations to create | `any` | `{}` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | Create, update, and delete timeout configurations for the load balancer | `map(string)` | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_nlb_enable_cross_zone_load_balancing"></a> [nlb\_enable\_cross\_zone\_load\_balancing](#input\_nlb\_enable\_cross\_zone\_load\_balancing) | If `true`, cross-zone load balancing of the Network load balancer will be enabled. For application load balancer this feature is always enabled (`true`) and cannot be disabled. Defaults to `true` | `bool` | `true` | no |
| <a name="input_nlb_enable_deletion_protection"></a> [nlb\_enable\_deletion\_protection](#input\_nlb\_enable\_deletion\_protection) | If `true`, deletion of the load balancer will be disabled via the AWS API. This will prevent Terraform from deleting the load balancer. | `bool` | n/a | yes |
| <a name="input_nlb_internal"></a> [nlb\_internal](#input\_nlb\_internal) | If true, the NLB will be internal. | `bool` | n/a | yes |
| <a name="input_nlb_ip_address_type"></a> [nlb\_ip\_address\_type](#input\_nlb\_ip\_address\_type) | The type of IP addresses used by the subnets for your Network load balancer. The possible values are `ipv4` and `dualstack` | `string` | n/a | yes |
| <a name="input_nlb_load_balancer_type"></a> [nlb\_load\_balancer\_type](#input\_nlb\_load\_balancer\_type) | The type of load balancer to create. Possible values are `application`, `gateway`, or `network`. The default value is `application` | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
