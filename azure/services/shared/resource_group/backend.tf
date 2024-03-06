terraform {
  backend "azurerm" {
    resource_group_name  = "ma-tf-backend-rg"
    storage_account_name = "matfbackendst"
    container_name       = "tfstate"
    key                  = "shared/rg/terraform.tfstate"
  }
}