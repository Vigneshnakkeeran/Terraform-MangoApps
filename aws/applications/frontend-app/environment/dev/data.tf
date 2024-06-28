# AZ data to be used in VPC module
data "aws_availability_zones" "available" {}
locals {
  azs = slice(data.aws_availability_zones.available.names, 0, 3)
}

# RDS MySQL password from parameter store 
data "aws_ssm_parameter" "rds_aurora_parameter_password" {
  name = "mangoapps-dev-aurora-pass"
}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

# For Fetching the Resource Group Data From the Statefile.
data "terraform_remote_state" "Statefile" {
  backend = "s3"
  config = {
    bucket = "mangoapps-tfbackend-bucket"
    key    = "backend-app/env/dev/terraform.tfstate"
    region = "us-west-2"
  }
}