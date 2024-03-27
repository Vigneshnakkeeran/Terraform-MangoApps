terraform {
  backend "s3" {
    bucket = "mangoapps-tfbackend-bucket"
    key    = "frontend-app/env/dev/terraform.tfstate"
    region = "us-west-2"
    # dynamodb_table = "mangoapps-terraform-backend-db"
  }
}

