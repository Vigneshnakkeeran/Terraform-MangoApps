data "aws_partition" "current" {}

 module "ses_lambda_module" {

  source = "../../../../modules/lambda"

  create_package         = false   

  s3_existing_package = {
     bucket = "cloudify-lambda-code"
     key = "lambda_function.zip"
  }

  lambda_role = module.ses_lambda_execution_role.role_arn
  
   function_name          = "ses-lambda1"
   runtime              = "ruby2.7"
   compatible_runtimes  = ["ruby2.7"]
   handler              = "lambda_function.lambda_handler"
   memory_size =          "128"

  layers = 	[module.lambda_layer_s3.lambda_layer_arn]

  publish = true

  environment_variables = {
    MA_BUCKET = "cloudifyops-dev-ses-bucket"   
    MA_REGION = "us-west-2"
    hub_mangoapps_test_terraform_com = "https://sqs.us-west-2.amazonaws.com/730335460835/mail-cloudifyops-income"
  }

 allowed_triggers = {
    SES = {
      principal  = "ses.amazonaws.com"
      source_arn = "arn:aws:ses:${data.aws_region.current.id}:${data.aws_caller_identity.current.account_id}:receipt-rule-set/*"
    }
  }
 }


module "lambda_layer_s3" {

  source = "../../../../modules/lambda"

  create_layer = true

  # create_role = false
  # lambda_role = module.lambda_edge_cloudfront.role_arn

  create_package         = false  
  layer_name          = "testsample"
  description         = "My amazing lambda layer (deployed from S3)"
  compatible_runtimes = ["ruby3.2"]

  s3_existing_package = {
     bucket = "cloudify-lambda-code"
     key = "layer.zip"
   } 

  store_on_s3 = false
}


################## Lambda for delete_custom_images #################

 module "delete_custom_images_lambda_module" {

  source = "../../../../modules/lambda"

  create_package         = false   

  s3_existing_package = {
     bucket = "cloudify-lambda-code"
     key = "delete_custom_images.zip"
  }

  lambda_role = module.lambda_execution_role_ssm.role_arn
  
   function_name          = "lambda-delete-custom-image"
   runtime              = "python3.12"
  #  compatible_runtimes  = ["ruby3.2"]
   handler              = "lambda_function.lambda_handler"
   memory_size =          "128"
   timeout = "900"

  publish = true
  environment_variables = {
    AWS_INSTANCE_ID = "${module.ec2_frontendserver.id}"  
  }

 }


################## Lambda for update_launch_template #################

 module "update_launch_template_lambda_module" {

  source = "../../../../modules/lambda"

  create_package         = false   

  s3_existing_package = {
     bucket = "cloudify-lambda-code"
     key = "update_launch_template.zip"
  }

  lambda_role = module.lambda_execution_role_ssm.role_arn
  
   function_name          = "lambda-update_launch_template"
   runtime              = "python3.12"
  #  compatible_runtimes  = ["ruby3.2"]
   handler              = "lambda_function.lambda_handler"
   memory_size =          "128"
   timeout = "900"

  publish = true

 }

#####Lambda @ edge##################

module "qaLamdaAdge-viewer-request" {

  providers = {
    aws = aws.us-east-1
  }
  source = "../../../../modules/lambda"

  lambda_at_edge = true
  create_package = false
  publish = true
  skip_destroy   = true

  function_name = "qaLamdaAdge-viewer-request"
  description   = "My awesome lambda@edge function"
  handler       = "lambda_function.lambda_handler"
  runtime       = "nodejs18.x"
  memory_size =          "128"
  ephemeral_storage_size = "512"
  timeout  = 3 

  lambda_role = module.lambda_edge_cloudfront.role_arn

  s3_existing_package = {
     bucket = "cloudifyops-lambda-code-us-east-1"
     key = "qaLamdaAdge-viewer-request.zip"
  } 

  allowed_triggers = {
    Cloudfront = {
      principal  = "cloudfront.amazonaws.com"
      source_arn = module.cdn_post_endpoint.cloudfront_distribution_arn
    }
  }  
}

#####Lambda @ edge viewer-response##################

module "qaLamdaAdge-viewer-response" {

  providers = {
    aws = aws.us-east-1
  }
  source = "../../../../modules/lambda"

  lambda_at_edge = true
  create_package = false
  publish = true
  skip_destroy   = true

  function_name = "qaLamdaAdge-viewer-response"
  description   = "My awesome lambda@edge function"
  handler       = "lambda_function.lambda_handler"
  runtime       = "nodejs18.x"
  memory_size =          "128"
  ephemeral_storage_size = "512"
  timeout  = 3 

  lambda_role = module.lambda_edge_cloudfront.role_arn

  s3_existing_package = {
     bucket = "cloudifyops-lambda-code-us-east-1"
     key = "qaLamdaAdge-viewer-response.zip"
  } 

  allowed_triggers = {
    Cloudfront = {
      principal  = "cloudfront.amazonaws.com"
      source_arn = module.cdn_post_endpoint.cloudfront_distribution_arn
    }
  }  
}


#####Lambda @ edge origin-request##################

module "qaLamdaAdge-origin-request" {

  providers = {
    aws = aws.us-east-1
  }
  source = "../../../../modules/lambda"

  lambda_at_edge = true
  create_package = false
  publish = true
  skip_destroy   = true

  function_name = "qaLamdaAdge-origin-request"
  description   = "My awesome lambda@edge function"
  handler       = "lambda_function.lambda_handler"
  runtime       = "nodejs18.x"
  memory_size =          "128"
  ephemeral_storage_size = "512"
  timeout  = 3   

  lambda_role = module.lambda_edge_cloudfront.role_arn

  s3_existing_package = {
     bucket = "cloudifyops-lambda-code-us-east-1"
     key = "qaLamdaAdge-origin-request.zip"
  } 

  allowed_triggers = {
    Cloudfront = {
      principal  = "cloudfront.amazonaws.com"
      source_arn = module.cdn_post_endpoint.cloudfront_distribution_arn
    }
  }  
}

module "ma-media-auth-service" {

  providers = {
    aws = aws.us-east-1
  }
  source = "../../../../modules/lambda"

  skip_destroy   = true
  lambda_at_edge = true
  create_package = false
  publish = true

  function_name = "ma-media-auth-service"
  description   = "ma-media-auth-service"
  handler       = "lambda_function.lambda_handler"
  runtime       = "nodejs18.x"
  memory_size =          "128"
  ephemeral_storage_size = "512"
  timeout = 3

  lambda_role = module.lambda_edge_cloudfront.role_arn

  s3_existing_package = {
     bucket = "cloudifyops-lambda-code-us-east-1"
     key = "ma_media_auth_service-bf.zip"
  } 

  allowed_triggers = {
    Cloudfront = {
      principal  = "cloudfront.amazonaws.com"
      source_arn = module.Mango_Media_endpoint.cloudfront_distribution_arn
    }
  }
  
}

module "add-origin-cache-control-lambda-funtion" {

  providers = {
    aws = aws.us-east-1
  }
  source = "../../../../modules/lambda"

  skip_destroy   = true
  lambda_at_edge = true
  create_package = false
  publish = true

  function_name = "add-origin-cache-control-lambda-funtion"
  description   = "add-origin-cache-control-lambda-funtion"
  handler       = "lambda_function.lambda_handler"
  runtime       = "nodejs18.x"
  memory_size =          "128"
  ephemeral_storage_size = "512"
  timeout = 3

  lambda_role = module.lambda_edge_cloudfront.role_arn

  s3_existing_package = {
     bucket = "cloudifyops-lambda-code-us-east-1"
     key = "add-origin-cache-control-lambda-funtion.zip"
  } 

  allowed_triggers = {
    Cloudfront = {
      principal  = "cloudfront.amazonaws.com"
      source_arn = module.Mango_Media_endpoint.cloudfront_distribution_arn
    }
  }
  
}

module "multi-s3-origin-request-lambda-function" {

  providers = {
    aws = aws.us-east-1
  }
  source = "../../../../modules/lambda"

  skip_destroy   = true
  lambda_at_edge = true
  create_package = false
  publish = true

  function_name = "multi-s3-origin-request-lambda-function"
  description   = "multi-s3-origin-request-lambda-function"
  handler       = "lambda_function.lambda_handler"
  runtime       = "nodejs18.x"
  memory_size =          "128"
  ephemeral_storage_size = "512"
  timeout = 3

  lambda_role = module.lambda_edge_cloudfront.role_arn

  s3_existing_package = {
     bucket = "cloudifyops-lambda-code-us-east-1"
     key = "multi-s3-origin-request-lambda-function.zip"
  } 

  allowed_triggers = {
    Cloudfront = {
      principal  = "cloudfront.amazonaws.com"
      source_arn = module.Mango_Media_endpoint.cloudfront_distribution_arn
    }
  }
  
}
