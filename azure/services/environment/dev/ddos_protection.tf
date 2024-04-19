module "ddos_protection" {
  source = "../../../modules/ddos_protection"
  location = var.location
  ddos_resource_group_name = data.terraform_remote_state.dev_resource_group.outputs.dev_rg
  network_ddos_protection_plan_name = var.ddos_protection_plan_name
  create_ddos_protection_plan =  var.create_ddos_protection_plan
}