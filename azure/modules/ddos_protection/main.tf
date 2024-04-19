resource "azurerm_network_ddos_protection_plan" "example" {
  count               = var.create_ddos_protection_plan ? 1 : 0  
  name                = var.network_ddos_protection_plan_name
  location            = var.location
  resource_group_name = var.ddos_resource_group_name
}