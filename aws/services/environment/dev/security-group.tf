# ASG Security group
module "bastion_security_group" {
  source                   = "../../../modules/security-group"
  create_sg                = var.create_bastion_sg
  description              = var.bastion_sg_description
  vpc_id                   = module.vpc.vpc_id
  name                     = "${var.client_name}-${var.environment}-bastion-sg"
  ingress_with_cidr_blocks = var.bastion_ingress_with_cidr_blocks
  # ingress_with_source_security_group_id = var.bastion_ingress_with_source_security_group_id
  egress_with_cidr_blocks = var.bastion_egress_with_cidr_blocks
  tags = {
    Created_by = "Terraform"
    Client     = var.client_name
    Env        = var.environment
  }
}


# ASG Security group
module "asg_security_group" {
  source                   = "../../../modules/security-group"
  create_sg                = var.create_asg_sg
  description              = var.asg_sg_description
  vpc_id                   = module.vpc.vpc_id
  name                     = "${var.client_name}-${var.environment}-asg-sg"
  ingress_with_cidr_blocks = var.asg_ingress_with_cidr_blocks
  # ingress_with_source_security_group_id = var.asg_ingress_with_source_security_group_id
  egress_with_cidr_blocks = var.asg_egress_with_cidr_blocks
  tags = {
    Created_by = "Terraform"
    Client     = var.client_name
    Env        = var.environment
  }
}

# RDS Security group
module "rds_security_group" {
  source                   = "../../../modules/security-group"
  create_sg                = var.create_rds_sg
  description              = var.rds_sg_description
  vpc_id                   = module.vpc.vpc_id
  name                     = "${var.client_name}-${var.environment}-rds-sg"
  ingress_with_cidr_blocks = var.rds_ingress_with_cidr_blocks
  # ingress_with_source_security_group_id = var.rds_ingress_with_source_security_group_id
  egress_with_cidr_blocks = var.rds_egress_with_cidr_blocks
  tags = {
    Created_by = "Terraform"
    Client     = var.client_name
    Env        = var.environment
  }
}