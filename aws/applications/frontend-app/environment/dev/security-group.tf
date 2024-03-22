
# ASG Security group
module "asg_security_group" {
  source                   = "../../../modules/security-group"
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
    source_security_group_id = "${module.bastion_security_group.security_group_id}"
  }
  ]
  egress_with_cidr_blocks = var.asg_egress_with_cidr_blocks
  
  tags = {
    Created_by = "Terraform"
    Client     = var.client_name
    Env        = var.environment
  }
}
