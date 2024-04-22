<!-- BEGIN_TF_DOCS -->
## Azure Network DDoS Protection Terraform Module

Terraform Module for provisioning a Azure Network DDoS Protection.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 3.93.0 |

## Providers
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 3.93.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ddos_protection"></a> [ddos\_protection](#module\_ddos\_protection) | mangoapps/azure/modules/ddos_protection | n/a |

## Resources
| Name | Type |
|------|------|
| [azurerm_network_ddos_protection_plan.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_ddos_protection_plan) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_ddos_protection_plan"></a> [create\_ddos\_protection\_plan](#input\_create\_ddos\_protection\_plan) | Should be true if you want to enable DDoS Protection | `bool` | n/a | yes |
| <a name="input_ddos_protection_plan_name"></a> [ddos\_protection\_plan\_name](#input\_ddos\_protection\_plan\_name) | Provide the name for DDoS Protection | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The location/region to keep all your network resources. To get the list of all locations with table format from azure cli, run 'az account list-locations -o table' | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | A container that holds related resources for an Azure solution | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
