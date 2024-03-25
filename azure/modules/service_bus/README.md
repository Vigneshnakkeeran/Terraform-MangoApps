## Azure Service Bus Terraform Module

Terraform Module for provisioning a Service Bus namespace. It also creates Topics, Topic subscriptions and queues within the service bus namespace.

## Usage

```shell
module "service_bus" {
  source = "./modules/service_bus"

  name        = "test-service-bus"
  resource_group_name =  "test-rg"
  location            = "eastus"

  sku ="Standard"

  topics = [
    {
      name = "test-topic"
      enable_partioning = true
      subscriptions = [
        {
          name = "queue-subscription"
          forward_to = "test-queue"
          max_delivery_count = 1
        }
      ]
    }
  ]
  queues = [
    {
      name = "test-queue" 
    }
  ]
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 3.93.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 3.93.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_servicebus"></a> [service_bus](#module\_service_bus) | mangoapps/azure/modules/service_bus | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_servicebus_namespace.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_namespace) | resource |
| [azurerm_servicebus_namespace_authorization_rule.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_namespace_authorization_rule) | resource |
| [azurerm_servicebus_queue.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_queue) | resource |
| [azurerm_servicebus_queue_authorization_rule.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_queue_authorization_rule) | resource |
| [azurerm_servicebus_subscription.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_subscription) | resource |
| [azurerm_servicebus_subscription_rule.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_subscription_rule) | resource |
| [azurerm_servicebus_topic.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_topic) | resource |
| [azurerm_servicebus_topic_authorization_rule.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_topic_authorization_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_service_bus_capacity"></a> [service\_bus\_capacity](#input\_service\_bus\_capacity) | The number of message units. | `number` | `0` | no |
| <a name="input_service_bus_namespace_authorization_rules"></a> [service\_bus\_namespace\_authorization\_rules](#input\_service\_bus\_namespace\_authorization\_rules) | List of namespace authorization rules for the service bus namespace. | `any` | `[]` | no |
| <a name="input_service_bus_queues"></a> [service\_bus\_queues](#input\_service\_bus\_queues) | List of queues in the service bus namespace | `any` | `[]` | no |
| <a name="input_service_bus_sku"></a> [service\_bus\_sku](#input\_service\_bus\_sku) | The SKU of the namespace. The options are: `Basic`, `Standard`, `Premium`. | `string` | `"Standard"` | no |
| <a name="input_service_bus_topics"></a> [service\_bus\_topics](#input\_service\_bus\_topics) | List of topics in the service bus namespace | `any` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The namespace ID. |
| <a name="output_name"></a> [name](#output\_name) | The namespace name. |
| <a name="output_service_bus_queues"></a> [service\_bus\_queues](#output\_service\_bus\_queues) | Service Bus Queues |
| <a name="output_service_bus_topics"></a> [service\_bus\_topics](#output\_service\_bus\_topics) | Service Bus Topics |