## Azure Storage Account Terraform Module

Terraform Module to create an Azure storage account with a set of containers (and access level), set of file shares (and quota), tables, queues and Blob lifecycle management.

## Usage

```shell
module "storage" {
  source  = "path/of/module"
  resource_group_name      ="test-rg"
  location                 = "eastus"
  storage_account_name     = "teststacc"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  account_tier             = "Standard"

  # To enable advanced threat protection set argument to `true`
  enable_advanced_threat_protection = false

  containers_list = [{ name = "test-container", access_type = "private" }]

  # Possible types are `SystemAssigned`, `UserAssigned`.
  managed_identity_type    = "SystemAssigned"
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
| <a name="module_storage"></a> [storage](#module\_storage) | mangoapps/azure/modules/storage_account | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_storage_account.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_container.container](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_storage_queue.queues](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_queue) | resource |
| [azurerm_storage_share.fileshare](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_share) | resource |
| [azurerm_storage_table.tables](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_table) | resource |source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_enable_storage_account_advanced_threat_protection"></a> [enable\_storage\_account\_advanced\_threat\_protection](#input\_enable\_storage\_account\_advanced\_threat\_protection) | If enabled, advanced threat protection is added for the storage account | `bool` | n/a | yes |
| <a name="input_enable_storage_account_containers"></a> [enable\_storage\_account\_containers](#input\_enable\_storage\_account\_containers) | If enabled, creates containers for the storage account | `bool` | n/a | yes |
| <a name="input_enable_storage_account_fileshares"></a> [enable\_storage\_account\_fileshares](#input\_enable\_storage\_account\_fileshares) | If enabled, creates file share for the storage account | `bool` | n/a | yes |
| <a name="input_storage_account_containers"></a> [storage\_account\_containers](#input\_storage\_account\_containers) | List of containers for the storage account | `list(object({ name = string, access_type = string }))` | n/a | yes |
| <a name="input_storage_account_fileshares"></a> [storage\_account\_fileshares](#input\_storage\_account\_fileshares) | List of file shares for the storage account | `list(object({ name = string, quota = number }))` | n/a | yes |
| <a name="input_storage_account_kind"></a> [storage\_account\_kind](#input\_storage\_account\_kind) | The type of storage account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2. | `string` | n/a | yes |
| <a name="input_storage_account_replication_type"></a> [storage\_account\_replication\_type](#input\_storage\_account\_replication\_type) | Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS. | `string` | n/a | yes |
| <a name="input_storage_account_tier"></a> [storage\_account\_tier](#input\_storage\_account\_tier) | Storage Account Tier | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_storage_account_id"></a> [storage\_account\_id](#output\_storage\_account\_id) | The ID of the storage account. |
| <a name="output_storage_account_name"></a> [storage\_account\_name](#output\_storage\_account\_name) | The name of the storage account. |