module "ec2_instance" {
  source  = "../../../modules/ec2"

  name = "${var.client_name}-${var.environment}-bastion-host"

  instance_type          = var.bastion_instance_type
  key_name               = var.asg_key_name
  monitoring             = true
  vpc_security_group_ids = [module.bastion_security_group.security_group_id]
  subnet_id              = module.vpc.public_subnets[0]

  tags = {
    Created_by  = "Terraform"
    Client      = var.client_name
    Environment = var.environment
  }
}
