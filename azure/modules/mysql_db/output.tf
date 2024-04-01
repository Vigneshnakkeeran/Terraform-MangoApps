output "server_id" {
  value       = azurerm_mysql_flexible_server.this[*].id
  description = "The ID of the mysql server."
}
output "server_name" {
  value       = azurerm_mysql_flexible_server.this[*].name
  description = "The name of the Mysql server"
}