# Azure Monitoring Code for Virtual Machines.
resource "azurerm_monitor_metric_alert" "example" {
  name                = "example-metricalert"
  resource_group_name = data.terraform_remote_state.dev_resource_group.outputs.dev_rg
  scopes              = [module.linux.vm_id]
  description         = "Action will be triggered when cpu utilizationb is greater than 50."
  target_resource_type = "Microsoft.Compute/virtualMachines"

  criteria {
    metric_namespace = "Microsoft.Compute/virtualMachines"
    metric_name      = "Percentage CPU"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 50
  }
 action {
    action_group_id = azurerm_monitor_action_group.main.id
  }
  depends_on = [ module.linux ]
}

# # Azure monitoring for Mysql
# resource "azurerm_monitor_metric_alert" "mysql" {
#   name                = "example-mysql-metricalert"
#   resource_group_name = data.terraform_remote_state.dev_resource_group.outputs.dev_rg
#   scopes              = [module.mysql_server_primary.server_id]
#   description         = "Action will be triggered when CPU utilization is greater than 50%."
#   target_resource_type = "Microsoft.DBforMySQL/servers"  # Adjusted for Azure MySQL database

#   criteria {
#     metric_namespace = "Microsoft.DBforMySQL/servers"  # Adjusted for Azure MySQL database
#     metric_name      = "cpu_percent"  # Adjusted for MySQL CPU metric
#     aggregation      = "Average"
#     operator         = "GreaterThan"
#     threshold        = 50
#   }

#   action {
#     action_group_id = azurerm_monitor_action_group.main.id
#   }

#   depends_on = [module.mysql_server_primary]
# }

# Define the action group with email receiver
resource "azurerm_monitor_action_group" "main" {
  name                = "mango-action-group"
  resource_group_name = data.terraform_remote_state.dev_resource_group.outputs.dev_rg
  short_name          = "mango01"
  location            = var.location
  email_receiver {
    name                    = "email"
    email_address           = "adarshashok.k@cloudifyops.com"  # Replace with your email address
    use_common_alert_schema = true
  }
}