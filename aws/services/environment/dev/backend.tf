terraform {
  backend "s3" {
    bucket = "mangoapps-tf-backend-bucket"
    key    = "env/dev/terraform.tfstate"
    region = "us-east-1"
    # dynamodb_table = "mangoapps-terraform-backend-db"
  }
}
