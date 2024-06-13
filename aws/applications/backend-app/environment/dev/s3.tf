module "s3" {
  source                               = "../../../../modules/s3"
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

####################### Cloudtrail #########################

data "aws_iam_policy_document" "cloudtrail_bucket_policy" {
  statement {
    effect = "Allow"
    principals {
      type = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
    actions = ["s3:GetBucketAcl"]
    resources = ["arn:aws:s3:::${var.client_name}-${var.environment}-cloudtrail-bucket"]
    condition {
      test     = "StringEquals"
      variable = "aws:SourceArn"
      values   = ["arn:aws:cloudtrail:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:trail/${var.client_name}-${var.environment}-cloudtrail"]
    }
  }

  statement {
    effect = "Allow"
    principals {
      type = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
    actions = ["s3:PutObject"]
    resources = ["arn:aws:s3:::${var.client_name}-${var.environment}-cloudtrail-bucket/*"]
    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }
    condition {
      test     = "StringEquals"
      variable = "aws:SourceArn"
      values   = ["arn:aws:cloudtrail:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:trail/${var.client_name}-${var.environment}-cloudtrail"]
    }
  }
}

module "cloudtrail_s3" {
  source                               = "../../../../modules/s3"
  bucket                               = "${var.client_name}-${var.environment}-cloudtrail-bucket"
  acl                                  = var.cloudtrail_bucket_acl
  versioning                           = var.cloudtrail_bucket_versioning
  block_public_acls                    = var.cloudtrail_bucket_block_public_acls
  block_public_policy                  = var.cloudtrail_bucket_block_public_policy
  ignore_public_acls                   = var.cloudtrail_bucket_ignore_public_acls
  restrict_public_buckets              = var.cloudtrail_bucket_restrict_public_buckets
  control_object_ownership             = var.cloudtrail_bucket_control_object_ownership
  object_ownership                     = var.cloudtrail_bucket_object_ownership
  server_side_encryption_configuration = var.cloudtrail_bucket_server_side_encryption_configuration
  attach_policy                        = true
  policy                               = data.aws_iam_policy_document.cloudtrail_bucket_policy.json
  tags = {
    Created_by = "Terraform"
    Client     = var.client_name
    Env        = var.environment
  }
}

####################### SES #########################

data "aws_iam_policy_document" "ses_bucket_policy" {
  statement {
    sid       = "AllowSESPuts"
    effect    = "Allow"
    actions   = ["s3:PutObject"]
    resources = ["arn:aws:s3:::${var.client_name}-${var.environment}-ses-bucket/*"]
    principals {
      type        = "Service"
      identifiers = ["ses.amazonaws.com"]
    }
    condition {
      test     = "StringEquals"
      variable = "aws:Referer"
      values   = ["730335460835"]
    }
  }
}

module "ses_s3" {
  source                               = "../../../../modules/s3"
  bucket                               = "${var.client_name}-${var.environment}-ses-bucket"
  acl                                  = var.ses_bucket_acl
  versioning                           = var.ses_bucket_versioning
  block_public_acls                    = var.ses_bucket_block_public_acls
  block_public_policy                  = var.ses_bucket_block_public_policy
  ignore_public_acls                   = var.ses_bucket_ignore_public_acls
  restrict_public_buckets              = var.ses_bucket_restrict_public_buckets
  control_object_ownership             = var.ses_bucket_control_object_ownership
  object_ownership                     = var.ses_bucket_object_ownership
  server_side_encryption_configuration = var.ses_bucket_server_side_encryption_configuration
  attach_policy                            = true
  policy                                   = data.aws_iam_policy_document.ses_bucket_policy.json
  tags = {
    Created_by = "Terraform"
    Client     = var.client_name
    Env        = var.environment
    Backup     = "True"
  }
}

############## Mango_Media_endpoint ##################

module "MangoMedia_s3_bucket" {    ##name lenght should now exceed more than 25 characters
  source                  = "../../../../modules/s3"
  bucket                  = "mango-media-cloudfront-bucket"
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
#  attach_policy                        = true
#  policy                               = data.aws_iam_policy_document.Mango_Media_endpoint.json
  # website = {
  #   index_document = "index.html"
  # }
  # versioning = {
  #   enabled = true
  # }
  tags = {
    purpose = "S3 Bucket for Mango Media endpoint code hosting"
  }
}
data "aws_iam_policy_document" "Mango_Media_endpoint_policy" {
  version         = "2012-10-17"
  statement {
    actions       = ["s3:GetObject"]
    resources     =  ["arn:aws:s3:::${module.MangoMedia_s3_bucket.s3_bucket_id}/*"]
    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }
    condition {
      values = ["${module.Mango_Media_endpoint.cloudfront_distribution_arn}"]
      test = "StringEquals"
      variable = "AWS:SourceArn"
    }
  }
}


resource "aws_s3_bucket_policy" "MangoMedia_s3_bucket_policy" {
  bucket = module.MangoMedia_s3_bucket.s3_bucket_id
  policy = data.aws_iam_policy_document.Mango_Media_endpoint_policy.json
}

################################################
