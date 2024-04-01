variable "mysql_server_name" {
  type        = string
  description = "The name which should be used for this MySQL Flexible Server. Changing this forces a new MySQL Flexible Server to be created."
}
variable "resource_group_name" {
  type        = string
  description = "The name of the Resource Group where the MySQL Flexible Server should exist. Changing this forces a new MySQL Flexible Server to be created."
}
variable "location" {
  type        = string
  description = "The Azure Region where the MySQL Flexible Server should exist. Changing this forces a new MySQL Flexible Server to be created."
}
variable "create_mode" {
  type        = string
  description = "The creation mode which can be used to restore or replicate existing servers. Possible values are `Default`, `PointInTimeRestore`, `GeoRestore`, and `Replica`. Changing this forces a new MySQL Flexible Server to be created."
}
variable "mysql_version" {
  type        = any
  description = "Specifies the version of MySQL to use. Valid values are 5.7, or 8.0. Changing this forces a new resource to be created."
  default = ""
}
variable "administrator_login" {
  type        = string
  description = "The Administrator login for the MySQL Flexible Server. Required when `create_mode` is `Default`. Changing this forces a new MySQL Flexible Server to be created."
}
variable "administrator_password" {
  type        = string
  description = "The Password associated with the administrator_login for the MySQL Flexible Server. Required when create_mode is Default."
}
variable "backup_retention_days" {
  type        = string
  description = "The backup retention days for the MySQL Flexible Server. Possible values are between 1 and 35 days. Defaults to 7."
}
variable "delegated_subnet_id" {
  type        = string
  description = "The ID of the virtual network subnet to create the MySQL Flexible Server. Changing this forces a new MySQL Flexible Server to be created."
}
variable "sku_name" {
  type        = string
  description = "The SKU Name for the MySQL Flexible Server. ///`sku_name` should start with SKU tier B (Burstable), GP (General Purpose), MO (Memory Optimized) like `B_Standard_B1s`./// "
}
variable "identity_ids" {
  type        = list(string)
  description = "A list of User Assigned Managed Identity IDs to be assigned to this MySQL Flexible Server."
}
variable "zone" {
  type        = string
  description = "Specifies the Availability Zone in which the standby Flexible Server should be located. Possible values are 1, 2 and 3."
}
variable "size_gb" {
  type        = string
  description = "The max storage allowed for the MySQL Flexible Server. Possible values are between 20 and 16384"
}
variable "to_provision_mysql" {
  type    = bool
  default = true
}