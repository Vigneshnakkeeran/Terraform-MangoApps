# Security Group For V-net Level
## Terraform module for creating the network security group for restricting the ingress traffic ## 
module "network-security-group" {
  source                     = "../../../modules/security_group"
  resource_group_name        = data.terraform_remote_state.dev_resource_group.outputs.dev_rg
  location                   = var.location 
  security_group_name        = "${var.client_name}-${var.environment}-${var.securitygroup_name}"
  tags                       = var.default_tags
  depends_on                 = [ module.network ]
  custom_rules = [
    {
      name                   = "ssh"
      priority               = 200
      direction              = "Inbound"
      access                 = "Allow"
      protocol               = "Tcp"
      source_port_range      = "*"
      destination_port_range = "22"
      source_address_prefix  = "172.16.0.0/16"
      description            = "description-myssh"
    },
    {
      name                   = "app"
      priority               = 201
      direction              = "Inbound"
      access                 = "Allow"
      protocol               = "Tcp"
      source_port_range      = "*"
      destination_port_range = "80"
      source_address_prefix  = "172.16.0.0/16"
      description            = "app-port"
    }
  ]
}

