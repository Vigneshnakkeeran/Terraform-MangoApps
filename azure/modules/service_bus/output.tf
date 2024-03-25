output "name" {
  value       = azurerm_servicebus_namespace.main.name
  description = "The namespace name."
}

output "id" {
  value       = azurerm_servicebus_namespace.main.id
  description = "The namespace ID."
}

output "service_bus_topics" {
  description = "Service Bus Topics"
  value = azurerm_servicebus_topic.main.*.name
}

output "service_bus_queues" {
  description = "Service Bus Queues"
  value = azurerm_servicebus_queue.main.*.name
}