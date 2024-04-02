module "cdn_post_endpoint" {
  source = "../../../../modules/cloudfront"

 # aliases = ["cdn.example.com"]

#  comment             = "My awesome CloudFront"
  enabled             = true
  is_ipv6_enabled     = true
  price_class         = "PriceClass_All"
  retain_on_delete    = false
  wait_for_deployment = false

#   create_origin_access_identity = true
#   origin_access_identities = {
#     s3_bucket_one = "My awesome CloudFront can access"
#   }

#   logging_config = {
#     bucket = "logs-my-cdn.s3.amazonaws.com"
#   }

  origin = {
    post_endpoint = {
      domain_name = "hub.mangoapps-test-terraform.com"
      custom_origin_config = {
        http_port              = 80
        https_port             = 443
        origin_protocol_policy = "match-viewer"
        origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
      }
    }

    # s3_one = {
    #   domain_name = "my-s3-bycket.s3.amazonaws.com"
    #   s3_origin_config = {
    #     origin_access_identity = "s3_bucket_one"
    #   }
    # }
  }

  default_cache_behavior = {
    target_origin_id           = "post_endpoint"
    viewer_protocol_policy     = "redirect-to-https"
    use_forwarded_values       = true
    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods  = ["GET", "HEAD"]
#    compress        = true
    query_string = true
    headers      = ["Origin"]
    cookies_forward = "none"
    min_ttl     = 1
    default_ttl = 604800
    max_ttl     = 2592000
    lambda_function_association = {

      # Valid keys: viewer-request, origin-request, viewer-response, origin-response
      viewer-request = {
        lambda_arn   = "${module.qaLamdaAdge-viewer-request.lambda_function_qualified_arn}" 
#        include_body = false
      }

      origin-request = {
        lambda_arn = "${module.qaLamdaAdge-viewer-response.lambda_function_qualified_arn}"
#        include_body = false      
      }
      viewer-response = {
        lambda_arn = "${module.qaLamdaAdge-origin-request.lambda_function_qualified_arn}"
#        include_body = false
      }
    }
  }

#   ordered_cache_behavior = [
#     {
#       path_pattern           = "/static/*"
#       target_origin_id       = "s3_one"
#       viewer_protocol_policy = "redirect-to-https"

#       allowed_methods = ["GET", "HEAD", "OPTIONS"]
#       cached_methods  = ["GET", "HEAD"]
#       compress        = true
#       query_string    = true
#     }
#   ]

  viewer_certificate = {
      cloudfront_default_certificate = true
  }
}

# module "Static_Content_endpoint" {
#   source = "../cloudfront"

#  # aliases = ["cdn.example.com"]

# #  comment             = "My awesome CloudFront"
#   enabled             = true
#   is_ipv6_enabled     = true
#   price_class         = "PriceClass_All"
#   retain_on_delete    = false
#   wait_for_deployment = false

# #   create_origin_access_identity = true
# #   origin_access_identities = {
# #     s3_bucket_one = "My awesome CloudFront can access"
# #   }

# #   logging_config = {
# #     bucket = "logs-my-cdn.s3.amazonaws.com"
# #   }

#   origin = {
#     Static_Content_endpoint = {
#       domain_name = "hub.mangoapps-test-terraform.com"
#       custom_origin_config = {
#         http_port              = 80
#         https_port             = 443
#         origin_protocol_policy = "match-viewer"
#         origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
#       }
#     }

#     # s3_one = {
#     #   domain_name = "my-s3-bycket.s3.amazonaws.com"
#     #   s3_origin_config = {
#     #     origin_access_identity = "s3_bucket_one"
#     #   }
#     # }
#   }

#   default_cache_behavior = {
#     target_origin_id           = "Static_Content_endpoint"
#     viewer_protocol_policy     = "allow-all"

#     allowed_methods = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
#     cached_methods  = ["GET", "HEAD"]
#     cache_policy_name           = "Managed-CachingOptimized"
#     compress        = true
#     use_forwarded_values       = false
#     # query_string = true
#     # headers      = ["Origin"]
#     # cookies_forward = "none"
#     min_ttl     = 1
#     default_ttl = 604800
#     max_ttl     = 2592000
# #     lambda_function_association = {

# #       # Valid keys: viewer-request, origin-request, viewer-response, origin-response
# #       viewer-request = {
# #         lambda_arn   = module.qaLamdaAdge-viewer-request.lambda_function_qualified_arn
# # #        include_body = false
# #       }

# #       origin-request = {
# #         lambda_arn = module.qaLamdaAdge-origin-request.lambda_function_qualified_arn
# # #        include_body = false      
# #       }
# #       viewer-response = {
# #         lambda_arn = module.qaLamdaAdge-viewer-response.lambda_function_qualified_arn
# # #        include_body = false
# #       }
# #     }
#   }

# #   ordered_cache_behavior = [
# #     {
# #       path_pattern           = "/static/*"
# #       target_origin_id       = "s3_one"
# #       viewer_protocol_policy = "redirect-to-https"

# #       allowed_methods = ["GET", "HEAD", "OPTIONS"]
# #       cached_methods  = ["GET", "HEAD"]
# #       compress        = true
# #       query_string    = true
# #     }
# #   ]

#   # viewer_certificate = {
#   #   acm_certificate_arn = "aws_acm_certificate.certificate.arn"
#   #   ssl_support_method  = "sni-only"
#   # }
# }

# locals {
#   domain_name = "mangoapps-test-terraform.com" # trimsuffix(data.aws_route53_zone.this.name, ".")
#   subdomain   = "awscloudfront"
# }

# module "Mango_Media_endpoint" {
#   source = "../cloudfront"
# #  depends_on          = [module.Mango_Media_endpoint_s3_bucket]

#   aliases = ["${local.subdomain}.${local.domain_name}"]

# #  comment             = "My awesome CloudFront"
#   enabled             = true
#   is_ipv6_enabled     = true
#   price_class         = "PriceClass_All"
#   retain_on_delete    = false
#   wait_for_deployment = false

#   create_origin_access_identity = true
#   origin_access_identities = {
#     s3_bucket_mango_media_endpoint = "s3_bucket_mango_media_endpoint-cloudfront-origin"
#   }

# #   logging_config = {
# #     bucket = "logs-my-cdn.s3.amazonaws.com"
# #   }

#   origin = {
#     Mango_Media_endpoint = {
#       domain_name = "${module.Mango_Media_endpoint_s3_bucket.s3_bucket_bucket_regional_domain_name}"
#       s3_origin_config = {
#         origin_access_identity = "s3_bucket_mango_media_endpoint"
#       }
#       # custom_origin_config = {
#       #   http_port              = 80
#       #   https_port             = 443
#       #   origin_protocol_policy = "https-only"
#       #   origin_ssl_protocols   = ["TLSv1.2"]
#       # }
#     }

#     # s3_one = {
#     #   domain_name = "s3_bucket_bucket_regional_domain_name" #module.s3_one.s3_bucket_bucket_regional_domain_name

#     # }
#   }

#   default_cache_behavior = {
#     target_origin_id           = "Mango_Media_endpoint"
#     viewer_protocol_policy     = "allow-all"

#     allowed_methods = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
#     cached_methods  = ["GET", "HEAD"]
# #    cache_policy_name           = "Managed-CachingOptimized"
# #    compress        = true
#     use_forwarded_values       = true
#     query_string = true
#     query_string_cache_keys = ["bucket_name"]
# #    headers      = ["Origin"]
#     cookies_forward = "none"
#     min_ttl     = 2592000
#     default_ttl = 2592000
#     max_ttl     = 31536000
#     lambda_function_association = {

#       # Valid keys: viewer-request, origin-request, viewer-response, origin-response
#       viewer-request = {
#         lambda_arn   = "${module.ma-media-auth-service.lambda_function_qualified_arn}"
# #        include_body = false
#       }

#       origin-request = {
#         lambda_arn = "${module.add-origin-cache-control-lambda-funtion.lambda_function_qualified_arn}"
# #        include_body = false      
#       }
#       viewer-response = {
#         lambda_arn = "${module.multi-s3-origin-request-lambda-function.lambda_function_qualified_arn}"
# #        include_body = false
#       }
#     }
#   }

#   ordered_cache_behavior = [
#     {
#       path_pattern           = "/static/*"
#       target_origin_id       = "s3_one"
#       viewer_protocol_policy = "redirect-to-https"

#       allowed_methods = ["GET", "HEAD", "OPTIONS"]
#       cached_methods  = ["GET", "HEAD"]
#       compress        = true
#       query_string    = true
#     }
#   ]

  # viewer_certificate = {
  #   acm_certificate_arn = "aws_acm_certificate.certificate.arn"
  #   ssl_support_method  = "sni-only"
  # }
# }
