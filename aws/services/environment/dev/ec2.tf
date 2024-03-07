module "ec2_instance" {
  source  = "../../../modules/ec2"

  name = "${var.client_name}-${var.environment}-bastion-host"

  instance_type          = "t2.micro"
  key_name               = var.asg_key_name
  monitoring             = true
  vpc_security_group_ids = ["sg-12345678"]
  subnet_id              = module.vpc.public_subnets[0]

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
