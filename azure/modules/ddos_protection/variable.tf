variable "create_ddos_protection_plan" {
  description = "Should be true if you want to enable DDoS Protection"
  default = false
  type = bool
}

variable "ddos_resource_group_name" {
  description = "A container that holds related resources for an Azure solution"
  default     = ""
  type        = string
}

variable "location" {
  description = "The location/region to keep all your network resources. To get the list of all locations with table format from azure cli, run 'az account list-locations -o table'"
  default     = ""
  type        = string
}

variable "network_ddos_protection_plan_name" {
  description = "Provide the name for DDoS Protection"
  default     = ""
  type        = string
}
