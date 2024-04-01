variable "resource_group_name" {
  type        = string
  description = "The name of the Resource Group where the MySQL Flexible Server should exist. Changing this forces a new MySQL Flexible Server to be created."
}
variable "mysql_db_name" {
  type        = string
  description = "Specifies the name of the MySQL Database, which needs to be a valid MySQL identifier. Changing this forces a new resource to be created."
}
variable "charset" {
  type        = string
  description = "Specifies the Charset for the MySQL Database, which needs to be a valid MySQL Charset 'https://dev.mysql.com/doc/refman/5.7/en/charset-charsets.html'. Changing this forces a new resource to be created."
  default = "utf8mb3"
}
variable "collation" {
  type        = string
  description = "Specifies the Collation for the MySQL Database, which needs to be a valid MySQL Collation 'https://dev.mysql.com/doc/refman/5.7/en/charset-mysql.html'. Changing this forces a new resource to be created."
  default = "utf8mb3_unicode_ci"
}
variable "server_name" {
  type        = string
  description = "Specifies the name of the MySQL Flexible Server. Changing this forces a new resource to be created."
}