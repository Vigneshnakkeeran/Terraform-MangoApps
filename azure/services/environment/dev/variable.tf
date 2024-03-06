################### Common Variables #######################
variable "location" {
  description = "The location/region to keep all your resources. To get the list of all locations with table format from azure cli, run 'az account list-locations -o table'"
  type        = string
  default     = ""
}
variable "resource_group_name" {
  description = "A container that holds related resources for an Azure solution"
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
  type    = any
}
variable "vnet_name" {
  type    = string
  description = "The name for vnet"
  default = ""
}
variable "address_spaces" {
  type    = list(string)
  default = []
  description = "address spaces for network" 
}
variable "subnet_prefixes" {
  type    = list(string)
  default = []
  description = "subnet prefixes for vnet" 
}
variable "subnet_names" {
  type    = list(string)
  default = []
  description = "subnet names for vnet"
}
variable "securitygroup_name" {
  type    = string
  default = ""
}