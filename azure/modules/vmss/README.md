<!-- BEGIN_TF_DOCS -->
# Azure Virtual Machines Scale Sets Terraform Module

Azure virtual machine scale sets let you create and manage a group of identical, load balanced VMs. The number of VM instances can automatically increase or decrease in response to demand or a defined schedule. Scale sets provide high availability to your applications, and allow you to centrally manage, configure, and update a large number of VMs.
## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.93.0 |


## Modules

| Name | Version |
|------|---------|
| <a name="provider_azure"></a> [azure](#provider\_azure) |  4.10 |

## Resources

| Name | Type |
|------|------|
| [azurerm_linux_virtual_machine_scale_set.linux_vmss](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine_scale_set) | resource |
| [azurerm_monitor_autoscale_setting.auto](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_autoscale_setting) | resource |
| [azurerm_monitor_diagnostic_setting.nsg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_monitor_diagnostic_setting.vmmsdiag](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_network_security_group.nsg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_network_security_rule.nsg_rule](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_virtual_machine_scale_set_extension.omsagent](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_scale_set_extension) | resource |
| [azurerm_windows_virtual_machine_scale_set.winsrv_vmss](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_virtual_machine_scale_set) | resource |
| [random_password.passwd](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [tls_private_key.rsa](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [azurerm_log_analytics_workspace.logws](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/log_analytics_workspace) | data source |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_storage_account.storeacc](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account) | data source |
| [azurerm_subnet.snet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_data_disks"></a> [additional\_data\_disks](#input\_additional\_data\_disks) | Adding additional disks capacity to add each instance (GB) | `list(number)` | `[]` | no |
| <a name="input_additional_data_disks_storage_account_type"></a> [additional\_data\_disks\_storage\_account\_type](#input\_additional\_data\_disks\_storage\_account\_type) | The Type of Storage Account which should back this Data Disk. Possible values include Standard\_LRS, StandardSSD\_LRS, Premium\_LRS and UltraSSD\_LRS. | `string` | `"Standard_LRS"` | no |
| <a name="input_admin_password"></a> [admin\_password](#input\_admin\_password) | The Password which should be used for the local-administrator on this Virtual Machine | `any` | `null` | no |
| <a name="input_admin_ssh_key_data"></a> [admin\_ssh\_key\_data](#input\_admin\_ssh\_key\_data) | specify the path to the existing ssh key to authenciate linux vm | `string` | `""` | no |
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username) | The username of the local administrator used for the Virtual Machine. | `string` | `"azureadmin"` | no |
| <a name="input_assign_public_ip_to_each_vm_in_vmss"></a> [assign\_public\_ip\_to\_each\_vm\_in\_vmss](#input\_assign\_public\_ip\_to\_each\_vm\_in\_vmss) | Create a virtual machine scale set that assigns a public IP address to each VM | `bool` | `false` | no |
| <a name="input_availability_zone_balance"></a> [availability\_zone\_balance](#input\_availability\_zone\_balance) | Should the Virtual Machines in this Scale Set be strictly evenly distributed across Availability Zones? | `bool` | `true` | no |
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | A list of Availability Zones in which the Virtual Machines in this Scale Set should be created in | `list` | <pre>[<br>  1,<br>  2,<br>  3<br>]</pre> | no |
| <a name="input_custom_image"></a> [custom\_image](#input\_custom\_image) | Proive the custom image to this module if the default variants are not sufficient | <pre>object({<br>    publisher = string<br>    offer     = string<br>    sku       = string<br>    version   = string<br>  })</pre> | `null` | no |
| <a name="input_disable_password_authentication"></a> [disable\_password\_authentication](#input\_disable\_password\_authentication) | Should Password Authentication be disabled on this Virtual Machine Scale Set? Defaults to true. | `bool` | `true` | no |
| <a name="input_dns_servers"></a> [dns\_servers](#input\_dns\_servers) | List of dns servers to use for network interface | `list` | `[]` | no |
| <a name="input_enable_accelerated_networking"></a> [enable\_accelerated\_networking](#input\_enable\_accelerated\_networking) | Should Accelerated Networking be enabled? Defaults to false. | `bool` | `false` | no |
| <a name="input_enable_automatic_instance_repair"></a> [enable\_automatic\_instance\_repair](#input\_enable\_automatic\_instance\_repair) | Should the automatic instance repair be enabled on this Virtual Machine Scale Set? | `bool` | `false` | no |
| <a name="input_enable_autoscale_for_vmss"></a> [enable\_autoscale\_for\_vmss](#input\_enable\_autoscale\_for\_vmss) | Manages a AutoScale Setting which can be applied to Virtual Machine Scale Sets | `bool` | `false` | no |
| <a name="input_enable_ip_forwarding"></a> [enable\_ip\_forwarding](#input\_enable\_ip\_forwarding) | Should IP Forwarding be enabled? Defaults to false | `bool` | `false` | no |
| <a name="input_enable_lb_nat_pool"></a> [enable\_lb\_nat\_pool](#input\_enable\_lb\_nat\_pool) | If enabled load balancer nat pool will be created for SSH if flavor is linux and for winrm if flavour is windows | `bool` | `false` | no |
| <a name="input_enable_load_balancer"></a> [enable\_load\_balancer](#input\_enable\_load\_balancer) | Controls if public load balancer should be created | `bool` | `true` | no |
| <a name="input_generate_admin_ssh_key"></a> [generate\_admin\_ssh\_key](#input\_generate\_admin\_ssh\_key) | Generates a secure private key and encodes it as PEM. | `bool` | `true` | no |
| <a name="input_grace_period"></a> [grace\_period](#input\_grace\_period) | Amount of time (in minutes, between 30 and 90, defaults to 30 minutes) for which automatic repairs will be delayed. | `string` | `"PT30M"` | no |
| <a name="input_hub_storage_account_name"></a> [hub\_storage\_account\_name](#input\_hub\_storage\_account\_name) | The name of the hub storage account to store logs | `any` | `null` | no |
| <a name="input_instances_count"></a> [instances\_count](#input\_instances\_count) | The number of Virtual Machines in the Scale Set. | `number` | `1` | no |
| <a name="input_lb_private_ip_address"></a> [lb\_private\_ip\_address](#input\_lb\_private\_ip\_address) | Private IP Address to assign to the Load Balancer. | `any` | `null` | no |
| <a name="input_license_type"></a> [license\_type](#input\_license\_type) | Specifies the type of on-premise license which should be used for this Virtual Machine. Possible values are None, Windows\_Client and Windows\_Server. | `string` | `"None"` | no |
| <a name="input_linux_distribution_list"></a> [linux\_distribution\_list](#input\_linux\_distribution\_list) | n/a | <pre>map(object({<br>    publisher = string<br>    offer     = string<br>    sku       = string<br>    version   = string<br>  }))</pre> | <pre>{<br>  "centos8": {<br>    "offer": "CentOS",<br>    "publisher": "OpenLogic",<br>    "sku": "7.5",<br>    "version": "latest"<br>  },<br>  "coreos": {<br>    "offer": "CoreOS",<br>    "publisher": "CoreOS",<br>    "sku": "Stable",<br>    "version": "latest"<br>  },<br>  "ubuntu1604": {<br>    "offer": "UbuntuServer",<br>    "publisher": "Canonical",<br>    "sku": "16.04-LTS",<br>    "version": "latest"<br>  },<br>  "ubuntu1804": {<br>    "offer": "UbuntuServer",<br>    "publisher": "Canonical",<br>    "sku": "18.04-LTS",<br>    "version": "latest"<br>  }<br>}</pre> | no |
| <a name="input_linux_distribution_name"></a> [linux\_distribution\_name](#input\_linux\_distribution\_name) | Variable to pick an OS flavour for Linux based VMSS possible values include: centos8, ubuntu1804 | `string` | `"ubuntu1804"` | no |
| <a name="input_load_balanced_port_list"></a> [load\_balanced\_port\_list](#input\_load\_balanced\_port\_list) | List of ports to be forwarded through the load balancer to the VMs | `list(number)` | `[]` | no |
| <a name="input_load_balancer_health_probe_port"></a> [load\_balancer\_health\_probe\_port](#input\_load\_balancer\_health\_probe\_port) | Port on which the Probe queries the backend endpoint. Default `80` | `number` | `80` | no |
| <a name="input_load_balancer_sku"></a> [load\_balancer\_sku](#input\_load\_balancer\_sku) | The SKU of the Azure Load Balancer. Accepted values are Basic and Standard. | `string` | `"Standard"` | no |
| <a name="input_load_balancer_type"></a> [load\_balancer\_type](#input\_load\_balancer\_type) | Controls the type of load balancer should be created. Possible values are public and private | `string` | `"private"` | no |
| <a name="input_log_analytics_workspace_name"></a> [log\_analytics\_workspace\_name](#input\_log\_analytics\_workspace\_name) | The name of log analytics workspace name | `any` | `null` | no |
| <a name="input_maximum_instances_count"></a> [maximum\_instances\_count](#input\_maximum\_instances\_count) | The maximum number of instances for this resource. Valid values are between 0 and 1000 | `string` | `""` | no |
| <a name="input_minimum_instances_count"></a> [minimum\_instances\_count](#input\_minimum\_instances\_count) | The minimum number of instances for this resource. Valid values are between 0 and 1000 | `any` | `null` | no |
| <a name="input_nat_pool_frontend_ports"></a> [nat\_pool\_frontend\_ports](#input\_nat\_pool\_frontend\_ports) | Optional override for default NAT ports | `list(number)` | <pre>[<br>  50000,<br>  50119<br>]</pre> | no |
| <a name="input_nsg_diag_logs"></a> [nsg\_diag\_logs](#input\_nsg\_diag\_logs) | NSG Monitoring Category details for Azure Diagnostic setting | `list` | <pre>[<br>  "NetworkSecurityGroupEvent",<br>  "NetworkSecurityGroupRuleCounter"<br>]</pre> | no |
| <a name="input_nsg_inbound_rules"></a> [nsg\_inbound\_rules](#input\_nsg\_inbound\_rules) | List of network rules to apply to network interface. | `list` | `[]` | no |
| <a name="input_os_disk_size_gb"></a> [os\_disk\_size\_gb](#input\_os\_disk\_size\_gb) | The Size of the Internal OS Disk in GB | `number` | `40` | no |
| <a name="input_os_disk_storage_account_type"></a> [os\_disk\_storage\_account\_type](#input\_os\_disk\_storage\_account\_type) | The Type of Storage Account which should back this the Internal OS Disk. Possible values include Standard\_LRS, StandardSSD\_LRS and Premium\_LRS. | `string` | `"StandardSSD_LRS"` | no |
| <a name="input_os_flavor"></a> [os\_flavor](#input\_os\_flavor) | Specify the flavour of the operating system image to deploy VMSS. Valid values are `windows` and `linux` | `string` | `"windows"` | no |
| <a name="input_os_upgrade_mode"></a> [os\_upgrade\_mode](#input\_os\_upgrade\_mode) | Specifies how Upgrades (e.g. changing the Image/SKU) should be performed to Virtual Machine Instances. Possible values are Automatic, Manual and Rolling. Defaults to Automatic | `string` | `"Automatic"` | no |
| <a name="input_overprovision"></a> [overprovision](#input\_overprovision) | Should Azure over-provision Virtual Machines in this Scale Set? This means that multiple Virtual Machines will be provisioned and Azure will keep the instances which become available first - which improves provisioning success rates and improves deployment time. You're not billed for these over-provisioned VM's and they don't count towards the Subscription Quota. Defaults to true. | `bool` | `false` | no |
| <a name="input_pip_diag_logs"></a> [pip\_diag\_logs](#input\_pip\_diag\_logs) | Load balancer Public IP Monitoring Category details for Azure Diagnostic setting | `list` | <pre>[<br>  "DDoSProtectionNotifications",<br>  "DDoSMitigationFlowLogs",<br>  "DDoSMitigationReports"<br>]</pre> | no |
| <a name="input_private_ip_address_allocation"></a> [private\_ip\_address\_allocation](#input\_private\_ip\_address\_allocation) | The allocation method for the Private IP Address used by this Load Balancer. Possible values as Dynamic and Static. | `string` | `"Dynamic"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | A container that holds related resources for an Azure solution | `string` | `""` | no |
| <a name="input_scale_in_cpu_percentage_threshold"></a> [scale\_in\_cpu\_percentage\_threshold](#input\_scale\_in\_cpu\_percentage\_threshold) | Specifies the threshold of the metric that triggers the scale in action. | `string` | `"20"` | no |
| <a name="input_scale_out_cpu_percentage_threshold"></a> [scale\_out\_cpu\_percentage\_threshold](#input\_scale\_out\_cpu\_percentage\_threshold) | Specifies the threshold % of the metric that triggers the scale out action. | `string` | `"80"` | no |
| <a name="input_scaling_action_instances_number"></a> [scaling\_action\_instances\_number](#input\_scaling\_action\_instances\_number) | The number of instances involved in the scaling action | `string` | `"1"` | no |
| <a name="input_single_placement_group"></a> [single\_placement\_group](#input\_single\_placement\_group) | Allow to have cluster of 100 VMs only | `bool` | `true` | no |
| <a name="input_source_image_id"></a> [source\_image\_id](#input\_source\_image\_id) | The ID of an Image which each Virtual Machine in this Scale Set should be based on | `any` | `null` | no |
| <a name="input_subnet_name"></a> [subnet\_name](#input\_subnet\_name) | The name of the subnet to use in VM scale set | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_virtual_machine_size"></a> [virtual\_machine\_size](#input\_virtual\_machine\_size) | The Virtual Machine SKU for the Scale Set, Default is Standard\_A2\_V2 | `string` | `"Standard_A2_v2"` | no |
| <a name="input_virtual_network_name"></a> [virtual\_network\_name](#input\_virtual\_network\_name) | The name of the virtual network | `string` | `""` | no |
| <a name="input_vmscaleset_name"></a> [vmscaleset\_name](#input\_vmscaleset\_name) | Specifies the name of the virtual machine scale set resource | `string` | `""` | no |
| <a name="input_windows_distribution_list"></a> [windows\_distribution\_list](#input\_windows\_distribution\_list) | n/a | <pre>map(object({<br>    publisher = string<br>    offer     = string<br>    sku       = string<br>    version   = string<br>  }))</pre> | <pre>{<br>  "mssql2017exp": {<br>    "offer": "SQL2017-WS2016",<br>    "publisher": "MicrosoftSQLServer",<br>    "sku": "Express",<br>    "version": "latest"<br>  },<br>  "windows2012r2dc": {<br>    "offer": "WindowsServer",<br>    "publisher": "MicrosoftWindowsServer",<br>    "sku": "2012-R2-Datacenter",<br>    "version": "latest"<br>  },<br>  "windows2016dc": {<br>    "offer": "WindowsServer",<br>    "publisher": "MicrosoftWindowsServer",<br>    "sku": "2016-Datacenter",<br>    "version": "latest"<br>  },<br>  "windows2019dc": {<br>    "offer": "WindowsServer",<br>    "publisher": "MicrosoftWindowsServer",<br>    "sku": "2019-Datacenter",<br>    "version": "latest"<br>  }<br>}</pre> | no |
| <a name="input_windows_distribution_name"></a> [windows\_distribution\_name](#input\_windows\_distribution\_name) | Variable to pick an OS flavour for Windows based VMSS possible values include: winserver, wincore, winsql | `string` | `"windows2019dc"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_admin_ssh_key_private"></a> [admin\_ssh\_key\_private](#output\_admin\_ssh\_key\_private) | The generated private key data in PEM format |
| <a name="output_admin_ssh_key_public"></a> [admin\_ssh\_key\_public](#output\_admin\_ssh\_key\_public) | The generated public key data in PEM format |
| <a name="output_linux_virtual_machine_scale_set_id"></a> [linux\_virtual\_machine\_scale\_set\_id](#output\_linux\_virtual\_machine\_scale\_set\_id) | The resource ID of the Linux Virtual Machine Scale Set. |
| <a name="output_linux_virtual_machine_scale_set_name"></a> [linux\_virtual\_machine\_scale\_set\_name](#output\_linux\_virtual\_machine\_scale\_set\_name) | The name of the Linux Virtual Machine Scale Set. |
| <a name="output_linux_virtual_machine_scale_set_unique_id"></a> [linux\_virtual\_machine\_scale\_set\_unique\_id](#output\_linux\_virtual\_machine\_scale\_set\_unique\_id) | The unique ID of the Linux Virtual Machine Scale Set. |
| <a name="output_linux_vm_password"></a> [linux\_vm\_password](#output\_linux\_vm\_password) | Password for the Linux VM |
| <a name="output_network_security_group_id"></a> [network\_security\_group\_id](#output\_network\_security\_group\_id) | The resource id of Network security group |
| <a name="output_windows_virtual_machine_scale_set_id"></a> [windows\_virtual\_machine\_scale\_set\_id](#output\_windows\_virtual\_machine\_scale\_set\_id) | The resource ID of the windows Virtual Machine Scale Set. |
| <a name="output_windows_virtual_machine_scale_set_name"></a> [windows\_virtual\_machine\_scale\_set\_name](#output\_windows\_virtual\_machine\_scale\_set\_name) | The name of the windows Virtual Machine Scale Set. |
| <a name="output_windows_virtual_machine_scale_set_unique_id"></a> [windows\_virtual\_machine\_scale\_set\_unique\_id](#output\_windows\_virtual\_machine\_scale\_set\_unique\_id) | The unique ID of the windows Virtual Machine Scale Set. |
| <a name="output_windows_vm_password"></a> [windows\_vm\_password](#output\_windows\_vm\_password) | Password for the windows VM |
<!-- END_TF_DOCS -->