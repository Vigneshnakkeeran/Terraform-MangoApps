output "server_id" {
  value       = azurerm_mysql_flexible_server.replica.id
  description = "The ID of the mysql server."
}