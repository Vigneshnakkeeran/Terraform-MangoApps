output "dev_rg" {
  description = "The address space of the newly created vNet"
  value       = azurerm_resource_group.dev_rg.name
}
output "dev_rg_id" {
  description = "The address space of the newly created vNet"
  value       = azurerm_resource_group.dev_rg.id
}