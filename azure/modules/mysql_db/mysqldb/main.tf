resource "azurerm_mysql_flexible_database" "this" {
  name                = var.mysql_db_name
  resource_group_name = var.resource_group_name
  server_name         = var.server_name
  charset             = var.charset  #"utf8"
  collation           = var.collation #"utf8_unicode_ci"
}