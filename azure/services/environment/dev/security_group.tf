# Security Group For V-net Level
## Terraform module for creating the network security group for restricting the ingress traffic ## 
module "network-security-group" {
  source                     = "../../../modules/security_group"
  resource_group_name        = data.terraform_remote_state.dev_resource_group.outputs.dev_rg
  location                   = var.location 
  security_group_name        = "${var.client_name}-${var.environment}-${var.securitygroup_name}"
  tags                       = var.default_tags
  depends_on                 = [ module.network ]
  custom_rules               = var.custom_rules
}