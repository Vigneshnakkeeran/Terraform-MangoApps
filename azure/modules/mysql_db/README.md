<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_mysql_flexible_server.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mysql_flexible_server) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_administrator_login"></a> [administrator\_login](#input\_administrator\_login) | The Administrator login for the MySQL Flexible Server. Required when `create_mode` is `Default`. Changing this forces a new MySQL Flexible Server to be created. | `string` | n/a | yes |
| <a name="input_administrator_password"></a> [administrator\_password](#input\_administrator\_password) | The Password associated with the administrator\_login for the MySQL Flexible Server. Required when create\_mode is Default. | `string` | n/a | yes |
| <a name="input_backup_retention_days"></a> [backup\_retention\_days](#input\_backup\_retention\_days) | The backup retention days for the MySQL Flexible Server. Possible values are between 1 and 35 days. Defaults to 7. | `string` | n/a | yes |
| <a name="input_create_mode"></a> [create\_mode](#input\_create\_mode) | The creation mode which can be used to restore or replicate existing servers. Possible values are `Default`, `PointInTimeRestore`, `GeoRestore`, and `Replica`. Changing this forces a new MySQL Flexible Server to be created. | `string` | n/a | yes |
| <a name="input_delegated_subnet_id"></a> [delegated\_subnet\_id](#input\_delegated\_subnet\_id) | The ID of the virtual network subnet to create the MySQL Flexible Server. Changing this forces a new MySQL Flexible Server to be created. | `string` | n/a | yes |
| <a name="input_identity_ids"></a> [identity\_ids](#input\_identity\_ids) | A list of User Assigned Managed Identity IDs to be assigned to this MySQL Flexible Server. | `list(string)` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The Azure Region where the MySQL Flexible Server should exist. Changing this forces a new MySQL Flexible Server to be created. | `string` | n/a | yes |
| <a name="input_mysql_server_name"></a> [mysql\_server\_name](#input\_mysql\_server\_name) | The name which should be used for this MySQL Flexible Server. Changing this forces a new MySQL Flexible Server to be created. | `string` | n/a | yes |
| <a name="input_mysql_version"></a> [mysql\_version](#input\_mysql\_version) | Specifies the version of MySQL to use. Valid values are 5.7, or 8.0. Changing this forces a new resource to be created. | `any` | `""` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the Resource Group where the MySQL Flexible Server should exist. Changing this forces a new MySQL Flexible Server to be created. | `string` | n/a | yes |
| <a name="input_size_gb"></a> [size\_gb](#input\_size\_gb) | The max storage allowed for the MySQL Flexible Server. Possible values are between 20 and 16384 | `string` | n/a | yes |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | The SKU Name for the MySQL Flexible Server. ///`sku_name` should start with SKU tier B (Burstable), GP (General Purpose), MO (Memory Optimized) like `B_Standard_B1s`./// | `string` | n/a | yes |
| <a name="input_to_provision_mysql"></a> [to\_provision\_mysql](#input\_to\_provision\_mysql) | n/a | `bool` | `true` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | Specifies the Availability Zone in which the standby Flexible Server should be located. Possible values are 1, 2 and 3. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_server_id"></a> [server\_id](#output\_server\_id) | The ID of the mysql server. |
| <a name="output_server_name"></a> [server\_name](#output\_server\_name) | The name of the Mysql server |
<!-- END_TF_DOCS -->