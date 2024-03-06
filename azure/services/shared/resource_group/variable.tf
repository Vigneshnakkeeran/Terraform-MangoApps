variable "location" {
  description = "The location/region to keep all your resources. To get the list of all locations with table format from azure cli, run 'az account list-locations -o table'"
  type        = string
  default     = "East US"
}
variable "dev_resource_group_name" {
  description = "A container that holds related resources for an Azure solution"
  type        = string
  default     = "mangoapps-development-rg"
}