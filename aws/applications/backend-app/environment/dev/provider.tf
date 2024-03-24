# Required Provider list
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.20"
    }
  }
}

# AWS Provider
provider "aws" {
  region = "us-west-2"
}
