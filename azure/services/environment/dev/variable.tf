################### Common Variables #######################

variable "location" {
  description = "The location/region to keep all your resources. To get the list of all locations with table format from azure cli, run 'az account list-locations -o table'"
  type        = string
  default     = ""
}

variable "default_tags" {
  type    = map(string)
  default = {}
}

variable "environment" {
  type = string
  default = ""
  description = "environment name 'int, prod, dev'" 
}

variable "client_name" {
  type = string
  default = ""
  description = "project name" 
}

################### Network Variables #######################

variable "use_for_each" {
  type        = bool
  description = "Use `for_each` instead of `count` to create multiple resource instances."
  nullable    = false
}

variable "address_space" {
  type        = string
  default     = "10.0.0.0/16"
  description = "The address space that is used by the virtual network."
}

variable "address_spaces" {
  type        = list(string)
  default     = []
  description = "The list of the address spaces that is used by the virtual network."
}

# If no values specified, this defaults to Azure DNS 
variable "dns_servers" {
  type        = list(string)
  default     = []
  description = "The DNS servers to be used with vNet."
}

variable "resource_group_location" {
  type        = string
  default     = null
  description = "The location/region where the virtual network is created. Changing this forces a new resource to be created."
}

variable "subnet_delegation" {
  type = map(list(object({
    name = string
    service_delegation = object({
      name    = string
      actions = optional(list(string))
    })
  })))
  default     = {}
  description = "`service_delegation` blocks for `azurerm_subnet` resource, subnet names as keys, list of delegation blocks as value, more details about delegation block could be found at the [document](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet#delegation)."
  nullable    = false
}

variable "subnet_enforce_private_link_endpoint_network_policies" {
  type        = map(bool)
  default     = {}
  description = "A map with key (string) `subnet name`, value (bool) `true` or `false` to indicate enable or disable network policies for the private link endpoint on the subnet. Default value is false."
}

variable "subnet_names" {
  type        = list(string)
  default     = ["subnet1"]
  description = "A list of public subnets inside the vNet."
}

variable "subnet_prefixes" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "The address prefix to use for the subnet."
}

variable "subnet_service_endpoints" {
  type        = map(list(string))
  default     = {}
  description = "A map with key (string) `subnet name`, value (list(string)) to indicate enabled service endpoints on the subnet. Default value is []."
}

variable "tags" {
  type = map(string)
  default = {
    environment = "dev"
  }
  description = "The tags to associate with your network and subnets."
}

# tflint-ignore: terraform_unused_declarations
variable "tracing_tags_enabled" {
  type        = bool
  default     = false
  description = "Whether enable tracing tags that generated by BridgeCrew Yor."
  nullable    = false
}

# tflint-ignore: terraform_unused_declarations
variable "tracing_tags_prefix" {
  type        = string
  default     = "avm_"
  description = "Default prefix for generated tracing tags"
  nullable    = false
}

variable "vnet_name" {
  type        = string
  default     = "acctvnet"
  description = "Name of the vnet to create."
}

################### Security Group Variables #######################

variable "securitygroup_name" {
  type        = string
  default     = ""
  description = "Name of the vnet to create."
}

# variable "custom_rules" {
#   description = "List of ingress rules to create where 'cidr_blocks' is used"
#   type        = list(map(string)) 
# }
variable "custom_rules" {
  type = list(object({
    name                   = string
    priority               = number
    direction              = string
    access                 = string
    protocol               = string
    source_port_range      = string
    destination_port_range = string
    source_address_prefix  = string
    description            = string
  }))
  description = "List of custom rules for network security"
}

########################## VMSS Variables ######################################

# variable "vmscaleset_name" {
#   description = "Specifies the name of the virtual machine scale set resource"
#   default     = ""
# }

# variable "linux_distribution_name" {
#   type        = string
#   default     = "ubuntu1804"
#   description = "Variable to pick an OS flavour for Linux based VMSS possible values include: centos8, ubuntu1804"
# }

# variable "os_flavor" {
#   description = "Specify the flavour of the operating system image to deploy VMSS. Valid values are `windows` and `linux`" 
# }

# variable "virtual_machine_size" {
#   description = "The Virtual Machine SKU for the Scale Set, Default is Standard_A2_V2" 
# }

# variable "instances_count" {
#   description = "The number of Virtual Machines in the Scale Set."
# }

# variable "enable_autoscale_for_vmss" {
#   description = "Manages a AutoScale Setting which can be applied to Virtual Machine Scale Sets"
#   default     = false
# }

# variable "minimum_instances_count" {
#   description = "The minimum number of instances for this resource. Valid values are between 0 and 1000"
#   default     = null
# }

# variable "maximum_instances_count" {
#   description = "The maximum number of instances for this resource. Valid values are between 0 and 1000"
#   default     = ""
# }

# variable "scale_out_cpu_percentage_threshold" {
#   description = "Specifies the threshold % of the metric that triggers the scale out action."
# }

# variable "scale_in_cpu_percentage_threshold" {
#   description = "Specifies the threshold of the metric that triggers the scale in action."
# }

# variable "scaling_action_instances_number" {
#   description = "The number of instances involved in the scaling action"
# }

# variable "generate_admin_ssh_key" {
#   description = "Generates a secure private key and encodes it as PEM."
#   default     = true
# }

# variable "admin_username" {
#   description = "The username of the local administrator used for the Virtual Machine."
# }

# variable "admin_password" {
#   description = "The Password which should be used for the local-administrator on this Virtual Machine"
#   default     = null
# }

# variable "os_disk_storage_account_type" {
#   description = "The Type of Storage Account which should back this the Internal OS Disk. Possible values include Standard_LRS, StandardSSD_LRS and Premium_LRS."
# }

# variable "assign_public_ip_to_each_vm_in_vmss" {
#   description = "Create a virtual machine scale set that assigns a public IP address to each VM"
# }

########################## Storage Account Variables ###################################

variable "storage_account_replication_type" {
  description = "Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS."
  type = string
}

variable "storage_account_kind" {
  description = "The type of storage account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2."
  type = string
}

variable "storage_account_tier" {
  description = "Storage Account Tier"
  type = string
}

variable "enable_storage_account_advanced_threat_protection" {
  description = "If enabled, advanced threat protection is added for the storage account"
  type = bool
}

variable "enable_storage_account_containers" {
  description = "If enabled, creates containers for the storage account"
  type = bool
}

variable "enable_storage_account_fileshares" {
  description = "If enabled, creates file share for the storage account"
  type = bool
}

variable "storage_account_containers" {
  description = "List of containers for the storage account"
  type = list(object({ name = string, access_type = string }))
}

variable "storage_account_fileshares" {
  description = "List of file shares for the storage account"
  type = list(object({ name = string, quota = number }))
}

########################## Azure VM Variables ###################################
variable "size" {
description = "the size of the machine"
default = ""
type = string  
}

########################## Aplication Gateway Variables ####################

# variable "virtual_network_name" {
#   description = "The name of the virtual network"
#   default     = ""
# }

# variable "subnet_name" {
#   description = "The name of the subnet to use in VM scale set"
#   default     = ""
# }

variable "enable_http2" {
  description = "Is HTTP2 enabled on the application gateway resource?"
  default     = ""
}

variable "vnet_resource_group_name" {
  description = "The resource group name where the virtual network is created"
  default     = null
}

variable "app_gateway_name" {
  description = "The name of the application gateway"
  default     = ""
}

variable "sku" {
  description = "The sku pricing model of v1 and v2"
  type = object({
    name     = string
    tier     = string
    capacity = optional(number)
  })
}

# variable "backend_address_pools" {
#   description = "List of backend address pools"
#   type = list(object({
#     name         = string
#     fqdns        = optional(list(string))
#     ip_addresses = optional(list(string))
#   }))
# }

# variable "backend_http_settings" {
#   description = "List of backend HTTP settings."
#   type = list(object({
#     name                                = string
#     cookie_based_affinity               = string
#     affinity_cookie_name                = optional(string)
#     path                                = optional(string)
#     enable_https                        = bool
#     probe_name                          = optional(string)
#     request_timeout                     = number
#     host_name                           = optional(string)
#     pick_host_name_from_backend_address = optional(bool)
#     authentication_certificate = optional(object({
#       name = string
#     }))
#     trusted_root_certificate_names = optional(list(string))
#     connection_draining = optional(object({
#       enable_connection_draining = bool
#       drain_timeout_sec          = number
#     }))
#   }))
# }

# variable "http_listeners" {
#   description = "List of HTTP/HTTPS listeners. SSL Certificate name is required"
#   type = list(object({
#     name                 = string
#     host_name            = optional(string)
#     host_names           = optional(list(string))
#     require_sni          = optional(bool)
#     ssl_certificate_name = optional(string)
#     firewall_policy_id   = optional(string)
#     ssl_profile_name     = optional(string)
#     custom_error_configuration = optional(list(object({
#       status_code           = string
#       custom_error_page_url = string
#     })))
#   }))
# }

# variable "request_routing_rules" {
#   description = "List of Request routing rules to be used for listeners."
#   type = list(object({
#     name                        = string
#     priority                    = string
#     rule_type                   = string
#     http_listener_name          = string
#     backend_address_pool_name   = optional(string)
#     backend_http_settings_name  = optional(string)
#     redirect_configuration_name = optional(string)
#     rewrite_rule_set_name       = optional(string)
#     url_path_map_name           = optional(string)
#   }))
#   default = []
# }

# variable "ssl_certificates" {
#   description = "List of SSL certificates data for Application gateway"
#   type = list(object({
#     name                = string
#     data                = optional(string)
#     password            = optional(string)
#     key_vault_secret_id = optional(string)
#   }))
#   default = []
# }


########################## WAF Variables ###################################

variable "waf_managed_rule_set_configuration" {
  description = "Managed rule set configuration."
  type = list(object({
    type    = optional(string, "OWASP")
    version = optional(string, "3.2")
    rule_group_override_configuration = optional(list(object({
      rule_group_name = optional(string, null)
      rule = optional(list(object({
        id      = string
        enabled = optional(bool)
        action  = optional(string)
      })), [])
    })))

  }))
  default = []
}

variable "waf_custom_rules_configuration" {
 description = <<EOD
Custom rules configuration object with following attributes:
```
- name:                           Gets name of the resource that is unique within a policy. This name can be used to access the resource.
- priority:                       Describes priority of the rule. Rules with a lower value will be evaluated before rules with a higher value.
- rule_type:                      Describes the type of rule. Possible values are `MatchRule` and `Invalid`.
- action:                         Type of action. Possible values are `Allow`, `Block` and `Log`.
- match_conditions_configuration: One or more `match_conditions` blocks as defined below.
- match_variable_configuration:   One or more match_variables blocks as defined below.
- variable_name:                  The name of the Match Variable. Possible values are RemoteAddr, RequestMethod, QueryString, PostArgs, RequestUri, RequestHeaders, RequestBody and RequestCookies.
- selector:                       Describes field of the matchVariable collection
- match_values:                   A list of match values.
- operator:                       Describes operator to be matched. Possible values are IPMatch, GeoMatch, Equal, Contains, LessThan, GreaterThan, LessThanOrEqual, GreaterThanOrEqual, BeginsWith, EndsWith and Regex.
- negation_condition:             Describes if this is negate condition or not
- transforms:                     A list of transformations to do before the match is attempted. Possible values are HtmlEntityDecode, Lowercase, RemoveNulls, Trim, UrlDecode and UrlEncode.
```
EOD
  type = list(object({
    name      = optional(string)
    priority  = optional(number)
    rule_type = optional(string)
    action    = optional(string)
    match_conditions_configuration = optional(list(object({
      match_variable_configuration = optional(list(object({
        variable_name = optional(string)
        selector      = optional(string, null)
      })))
      match_values       = optional(list(string))
      operator           = optional(string)
      negation_condition = optional(string, null)
      transforms         = optional(list(string), null)
    })))
  }))
  default = []
}

variable "policy_mode" {
  description = "Policy Mode"
  type = string
}

############################### Service Bus Variables #################################

variable "service_bus_sku" {
  type        = string
  default     = "Standard"
  description = "The SKU of the namespace. The options are: `Basic`, `Standard`, `Premium`."
}

variable "service_bus_capacity" {
  type        = number
  default     = 0
  description = "The number of message units."
}

variable "service_bus_namespace_authorization_rules" {
  type        = any
  default     = []
  description = "List of namespace authorization rules for the service bus namespace."
}

variable "service_bus_topics" {
  type = any
  default = []
  description = "List of topics in the service bus namespace"
}

variable "service_bus_queues" {
  type = any
  default = []
  description = "List of queues in the service bus namespace"
}

###################### Azure Mysql #################################
variable "enable_mysql" {
  type    = bool
  default = true
}
variable "mysql_managed_identity_name" {
  type        = string
  description = "Managed Identity name for Mysql server."
  default     = "mi-mysql"
}
variable "mysql_server_name" {
  type        = string
  description = "The name which should be used for this MySQL Flexible Server. Changing this forces a new MySQL Flexible Server to be created."
  default     = "mysql"
}
variable "create_mode" {
  type        = string
  description = "The creation mode which can be used to restore or replicate existing servers. Possible values are `Default`, `PointInTimeRestore`, `GeoRestore`, and `Replica`. Changing this forces a new MySQL Flexible Server to be created."
  default     = "Default"
}
variable "backup_retention_days" {
  type        = string
  description = "The backup retention days for the MySQL Flexible Server. Possible values are between 1 and 35 days. Defaults to 7."
  default     = "7"
}
variable "mysql_sku_name" {
  type        = string
  description = "The SKU Name for the MySQL Flexible Server. ///`sku_name` should start with SKU tier B (Burstable), GP (General Purpose), MO (Memory Optimized) like `B_Standard_B1s`./// "
  default     = "GP_Standard_D2ads_v5"
}
variable "mysql_admin_user" {
  type        = string
  description = "admin username of mysql flexible server"
  default     = ""
}
variable "mysql_version" {
  type        = any
  description = "Specifies the version of MySQL to use. Valid values are 5.7, and 8.0.21. Changing this forces a new resource to be created."
  default     = "8.0.21"  
}
variable "mysql_db_name" {
  type        = string
  description = "Specifies the name of the MySQL Database, which needs to be a valid MySQL identifier. Changing this forces a new resource to be created."
  default     = "tools"
}
variable "charset" {
  type        = string
  description = "Specifies the Charset for the MySQL Database, which needs to be a valid MySQL Charset 'https://dev.mysql.com/doc/refman/5.7/en/charset-charsets.html'. Changing this forces a new resource to be created."
  default     = "utf8mb3"
}
variable "collation" {
  type        = string
  description = "Specifies the Collation for the MySQL Database, which needs to be a valid MySQL Collation 'https://dev.mysql.com/doc/refman/5.7/en/charset-mysql.html'. Changing this forces a new resource to be created."
  default     = "utf8mb3_unicode_ci"
}
variable "zone" {
  type        = string
  description = "Specifies the Availability Zone in which this MySQL Flexible Server should be located. Possible values are 1, 2 and 3."
  default     = "2"
}
variable "size_gb" {
  type        = string
  description = "The max storage allowed for the MySQL Flexible Server. Possible values are between 20 and 16384"
  default     = "100"
}
variable "mysql_keyvault_secret_name" {
  type        = string
  description = "mysql database secret name"
  default     = "mysql-secretkey"
}
#################### mysqldb replica 01 #######################
variable "mysql_replica_01_server_name" {
  type        = string
  description = "The name which should be used for Replica MySQL Flexible Server."
  default     = "mysql-replica1"
}
variable "mysql_replica_01_zone" {
  type        = string
  description = "Specifies the Availability Zone in which this MySQL Flexible Server should be located. Possible values are 1, 2 and 3."
  default     = "2"
}
#################### mysqldb replica 02 #######################
variable "mysql_replica_02_server_name" {
  type        = string
  description = "The name which should be used for Replica MySQL Flexible Server. "
  default     = "mysql-replica2"
}
variable "mysql_replica_02_zone" {
  type        = string
  description = "Specifies the Availability Zone in which this MySQL Flexible Server should be located. Possible values are 1, 2 and 3."
  default     = "2"
}

#################### DDoS Protection ############################
variable "create_ddos_protection_plan" {
  description = "Should be true if you want to enable DDoS Protection"
  type = bool
}

variable "ddos_protection_plan_name" {
  description = "Provide the name for DDoS Protection"
  type        = string
}

variable "ddos_resource_group_name" {
  description = "A container that holds related resources for an Azure solution"
  default = null
  type        = string
}