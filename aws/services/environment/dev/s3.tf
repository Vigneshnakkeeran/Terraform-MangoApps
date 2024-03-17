module "s3" {
  source                               = "../../../modules/s3"
  bucket                               = "${var.client_name}-${var.environment}-bucket"
  acl                                  = var.acl
  versioning                           = var.versioning
  block_public_acls                    = var.block_public_acls
  block_public_policy                  = var.block_public_policy
  ignore_public_acls                   = var.ignore_public_acls
  restrict_public_buckets              = var.restrict_public_buckets
  control_object_ownership             = var.control_object_ownership
  object_ownership                     = var.object_ownership
  server_side_encryption_configuration = var.server_side_encryption_configuration
  tags = {
    Created_by = "Terraform"
    Client     = var.client_name
    Env        = var.environment
  }
}

module "cloudtrail_s3" {
  source                               = "../../../modules/s3"
  bucket                               = "${var.client_name}-${var.environment}-cloudfront-bucket"
  acl                                  = var.cloudtrail_bucket_acl
  versioning                           = var.cloudtrail_bucket_versioning
  block_public_acls                    = var.cloudtrail_bucket_block_public_acls
  block_public_policy                  = var.cloudtrail_bucket_block_public_policy
  ignore_public_acls                   = var.cloudtrail_bucket_ignore_public_acls
  restrict_public_buckets              = var.cloudtrail_bucket_restrict_public_buckets
  control_object_ownership             = var.cloudtrail_bucket_control_object_ownership
  object_ownership                     = var.cloudtrail_bucket_object_ownership
  server_side_encryption_configuration = var.cloudtrail_bucket_server_side_encryption_configuration
  tags = {
    Created_by = "Terraform"
    Client     = var.client_name
    Env        = var.environment
  }
}


