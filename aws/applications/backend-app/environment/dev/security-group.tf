# Bastion Security group
module "bastion_security_group" {
  source                   = "../../../../modules/security-group"
  create_sg                = var.create_bastion_sg
  description              = var.bastion_sg_description
  vpc_id                   = module.vpc.vpc_id
  name                     = "${var.client_name}-${var.environment}-bastion-sg"
  ingress_with_cidr_blocks = var.bastion_ingress_with_cidr_blocks
  egress_with_cidr_blocks = var.bastion_egress_with_cidr_blocks
  tags = {
    Created_by = "Terraform"
    Client     = var.client_name
    Env        = var.environment
  }
}

# Backend Security Group 
module "backend_security_group" {
  source                   = "../../../../modules/security-group"
  create_sg                = var.create_backend_sg
  description              = var.backend_sg_description
  vpc_id                   = module.vpc.vpc_id
  name                     = "${var.client_name}-${var.environment}-private-sg"
  ingress_with_source_security_group_id = [
  {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    description = "SSH Access to instances"
    source_security_group_id = module.bastion_security_group.security_group_id
  }
  ]
  egress_with_cidr_blocks = var.asg_egress_with_cidr_blocks
  
  tags = {
    Created_by = "Terraform"
    Client     = var.client_name
    Env        = var.environment
  }
}
# ASG Security group
module "asg_security_group" {
  source                   = "../../../../modules/security-group"
  create_sg                = var.create_asg_sg
  description              = var.asg_sg_description
  vpc_id                   = module.vpc.vpc_id
  name                     = "${var.client_name}-${var.environment}-asg-sg"
  ingress_with_source_security_group_id = [
  {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    description = "SSH Access to instances"
    source_security_group_id = module.bastion_security_group.security_group_id
  }
  ]
  egress_with_cidr_blocks = var.asg_egress_with_cidr_blocks
  
  tags = {
    Created_by = "Terraform"
    Client     = var.client_name
    Env        = var.environment
  }
}

 # RDS Security group
module "rds_security_group" {
  source                   = "../../../../modules/security-group"
  create_sg                = var.create_rds_sg
  description              = var.rds_sg_description
  vpc_id                   = module.vpc.vpc_id
  name                     = "${var.client_name}-${var.environment}-rds-sg"
  ingress_with_source_security_group_id = [
    {
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      description = "Backend server access"
      source_security_group_id = module.backend_security_group.security_group_id
    },
    {
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      description = "Backend server access"
      source_security_group_id = module.asg_security_group.security_group_id
    }
  ]
  egress_with_cidr_blocks = var.rds_egress_with_cidr_blocks
  tags = {
    Created_by = "Terraform"
    Client     = var.client_name
    Env        = var.environment
  }
}

# Application LoadBalancer Security group
module "alb_security_group" {
  source                   = "../../../../modules/security-group"
  create_sg                = var.create_alb_sg
  description              = var.alb_sg_description
  vpc_id                   = module.vpc.vpc_id
  name                     = "${var.client_name}-${var.environment}-alb-sg"
  ingress_with_source_security_group_id = [
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      description = "nlb sg access"
      source_security_group_id = module.nlb_security_group.security_group_id
    },
  {
    from_port   = 5223
    to_port     = 5223
    protocol    = "tcp"
    source_security_group_id = module.nlb_security_group.security_group_id
  },
  {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    source_security_group_id = module.nlb_security_group.security_group_id
  }
]
  # ingress_with_source_security_group_id = var.rds_ingress_with_source_security_group_id
  egress_with_cidr_blocks = var.alb_egress_with_cidr_blocks
  tags = {
    Created_by = "Terraform"
    Client     = var.client_name
    Env        = var.environment
  }
}

# Network LoadBalancer Security group
module "nlb_security_group" {
  source                   = "../../../../modules/security-group"
  create_sg                = var.create_nlb_sg
  description              = var.nlb_sg_description
  vpc_id                   = module.vpc.vpc_id
  name                     = "${var.client_name}-${var.environment}-nlb-sg"
  ingress_with_cidr_blocks = [
  {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    description = "nlb sg access"
    cidr_blocks = "0.0.0.0/0"
  },
  {
    from_port   = 5223
    to_port     = 5223
    protocol    = "tcp"
    cidr_blocks = "0.0.0.0/0"
  },
  {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = "0.0.0.0/0"
  }
]
  # ingress_with_source_security_group_id = var.rds_ingress_with_source_security_group_id
  egress_with_cidr_blocks = var.alb_egress_with_cidr_blocks
  tags = {
    Created_by = "Terraform"
    Client     = var.client_name
    Env        = var.environment
  }
}
