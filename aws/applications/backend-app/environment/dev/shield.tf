module "aws_shield" {
  source = "../../../modules/shield"

  name = "${var.client_name}-${var.environment}-shield"
  associated_arns = [module.alb.arn]

  tags = {
    Created_by  = "Terraform"
    Client      = var.client_name
    Environment = var.environment
  }
}