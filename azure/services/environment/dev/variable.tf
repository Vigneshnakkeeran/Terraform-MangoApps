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

variable "custom_rules" {
  description = "List of ingress rules to create where 'cidr_blocks' is used"
  type        = list(map(string))
}

########################## VMSS Variables ######################################

variable "vmscaleset_name" {
  description = "Specifies the name of the virtual machine scale set resource"
  default     = ""
}

variable "linux_distribution_name" {
  type        = string
  default     = "ubuntu1804"
  description = "Variable to pick an OS flavour for Linux based VMSS possible values include: centos8, ubuntu1804"
}

variable "os_flavor" {
  description = "Specify the flavour of the operating system image to deploy VMSS. Valid values are `windows` and `linux`" 
}

variable "virtual_machine_size" {
  description = "The Virtual Machine SKU for the Scale Set, Default is Standard_A2_V2" 
}

variable "instances_count" {
  description = "The number of Virtual Machines in the Scale Set."
}

variable "enable_autoscale_for_vmss" {
  description = "Manages a AutoScale Setting which can be applied to Virtual Machine Scale Sets"
  default     = false
}

variable "minimum_instances_count" {
  description = "The minimum number of instances for this resource. Valid values are between 0 and 1000"
  default     = null
}

variable "maximum_instances_count" {
  description = "The maximum number of instances for this resource. Valid values are between 0 and 1000"
  default     = ""
}

variable "scale_out_cpu_percentage_threshold" {
  description = "Specifies the threshold % of the metric that triggers the scale out action."
}

variable "scale_in_cpu_percentage_threshold" {
  description = "Specifies the threshold of the metric that triggers the scale in action."
}

variable "scaling_action_instances_number" {
  description = "The number of instances involved in the scaling action"
}

variable "generate_admin_ssh_key" {
  description = "Generates a secure private key and encodes it as PEM."
  default     = true
}

variable "admin_username" {
  description = "The username of the local administrator used for the Virtual Machine."
}

variable "admin_password" {
  description = "The Password which should be used for the local-administrator on this Virtual Machine"
  default     = null
}

variable "os_disk_storage_account_type" {
  description = "The Type of Storage Account which should back this the Internal OS Disk. Possible values include Standard_LRS, StandardSSD_LRS and Premium_LRS."
}

variable "assign_public_ip_to_each_vm_in_vmss" {
  description = "Create a virtual machine scale set that assigns a public IP address to each VM"
}

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