data "aws_lb_target_group" "example" {
  name = "TGAppServer443"
}

# ASG with block device mapping
module "asg" {
  source = "../../../../modules/asg"

  name = "${var.client_name}-${var.environment}-asg"

  min_size                  = var.asg_min_size
  max_size                  = var.asg_max_size
  desired_capacity          = var.asg_desired_size
  wait_for_capacity_timeout = 0
  health_check_type         = "EC2"
  vpc_zone_identifier       = data.terraform_remote_state.Statefile.outputs.private_subnets

  # Launch template
  launch_template_name        = "${var.client_name}-${var.environment}-asg-Launch-template"
  launch_template_description = "Launch template for ${var.client_name} ${var.environment} environment"

  key_name        = var.asg_key_name
  security_groups = [ data.terraform_remote_state.Statefile.outputs.asg_sg_id ]

  image_id          = var.asg_ami_id
  user_data         = "${base64encode(file("user_data.sh"))}"
  instance_type     = var.asg_instance_type
  ebs_optimized     = var.asg_instance_ebs_optimized
  enable_monitoring = var.enable_asg_monitoring
  target_group_arns = [data.terraform_remote_state.Statefile.outputs.alb_target_group_asg_arn] 

  # IAM role & instance profile
  create_iam_instance_profile = var.create_asg_iam_instance_profile
  iam_role_name               = "${var.client_name}-${var.environment}-asg-instance-role"
  iam_role_description        = "IAM role for asg instance profile in ${var.client_name} ${var.environment} environment"

  iam_role_policies = {
    AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
  }

  block_device_mappings = var.asg_volume_mapping

  metadata_options = {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
  }

  tags = {
    Created_by  = "Terraform"
    Client      = var.client_name
    Environment = var.environment
  }
}