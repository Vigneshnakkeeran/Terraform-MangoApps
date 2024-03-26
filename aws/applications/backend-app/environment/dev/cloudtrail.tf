module "cloudtrail" {
  source = "../../../../modules/cloudtrail"

  enable_cloudtrail             = var.enable_cloudtrail
  name                          = "${var.client_name}-${var.environment}-cloudtrail" 
  enable_logging                = var.enable_logging
  enable_log_file_validation    = var.enable_log_file_validation
  include_global_service_events = var.include_global_service_events
  is_multi_region_trail         = var.is_multi_region_trail
  is_organization_trail         = var.is_organization_trail
  s3_bucket_name                = module.cloudtrail_s3.s3_bucket_id

  tags = {
    Created_by  = "Terraform"
    Client      = var.client_name
    Environment = var.environment
  }
}