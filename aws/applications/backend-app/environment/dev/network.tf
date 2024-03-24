# Network Module
module "vpc" {
  source = "../../../../modules/network"
  name   = "${var.client_name}-${var.environment}-vpc"
  cidr   = var.vpc_cidr
  azs    = local.azs
  public_subnets                     = var.public_subnets
  private_subnets                    = var.private_subnets
  enable_nat_gateway                = var.enable_nat_gateway
  single_nat_gateway                = var.single_nat_gateway
  one_nat_gateway_per_az            = var.one_nat_gateway_per_az
  create_igw = var.create_igw
  tags = {
    Created_by = "Terraform"
    Client     = var.client_name
    Env        = var.environment
  }
}
