 module "my_lambda_module" {
   source               = "../lambda"
   create_layer = true
   s3_bucket          =  "cloudify-lambda-code"
   s3_key_function_code = "lambda_function.zip"
   lambda_function_name = "ses-lambda-function"  
   layer_name           = "ses-lambda-layer" 
#   layer_runtime        = ["nodejs18.x"]
   s3_key_layer         = "layer.zip"
   role                 = module.ses_lambda_execution_role.role_arn
   runtime              = "ruby3.2"
   compatible_runtimes  = ["ruby3.2"]
   handler              = "lambda_function.lambda_handler"
   memory_size =          "128"
#   lambda_permission_source_arn = "arn:aws:ses:${data.aws_region.current.id}:${data.aws_caller_identity.current.account_id}:receipt-rule-set/*"
  environment_variables = {
    AWS_INCOMING_BUCKET = "hub-mangoapps-test-terraform-com"   
    AWS_REGION = "us-west-2"
    hub_mangoapps_test_terraform_com = "https://sqs.eu-west-1.amazonaws.com/760042596542/hub-mangoapps-test-terraform-com"
  }
 }
# resource "aws_lambda_permission" "lambda_permission" {
#   statement_id  = "AllowSESLambdaInvocation"
#   action        = "lambda:InvokeFunction"
#   function_name = module.my_lambda_module.function_arn  # Corrected reference
#   principal     = "ses.amazonaws.com"
#   source_arn    = "arn:aws:ses:${data.aws_region.current.id}:${data.aws_caller_identity.current.account_id}:receipt-rule-set/*"  #module.ses_email.ses_receipt_rule_arn               
# }

 module "qaLamdaAdge-viewer-request" {
   source               = "../lambda"
   create_layer = false
   lambda_function_name = "qaLamdaAdge-viewer-request" 
   s3_bucket          =  "cloudify-lambda-code"
   s3_key_function_code = "qaLamdaAdge-viewer-request.zip"
   role                 = module.lambda_edge_cloudfront.role_arn
   runtime              = "nodejs18.x"
   handler              = "lambda_function.lambda_handler"
   memory_size =          "128"
   ephemeral_storage_size = "512"
 }

 module "qaLamdaAdge-viewer-response" {
   source               = "../lambda"
   create_layer = false
   lambda_function_name = "qaLamdaAdge-viewer-response" 
   s3_bucket          =  "cloudify-lambda-code"
   s3_key_function_code = "qaLamdaAdge-viewer-response.zip"
   role                 = module.lambda_edge_cloudfront.role_arn
   runtime              = "nodejs18.x"
   handler              = "lambda_function.lambda_handler"
   memory_size =          "128"
   ephemeral_storage_size = "512"
 }

  module "qaLamdaAdge-origin-request" {
   source               = "../lambda"
   create_layer = false
   lambda_function_name = "qaLamdaAdge-origin-request" 
   s3_bucket          =  "cloudify-lambda-code"
   s3_key_function_code = "qaLamdaAdge-origin-request.zip"
   role                 = module.lambda_edge_cloudfront.role_arn
   runtime              = "nodejs18.x"
   handler              = "lambda_function.lambda_handler"
   memory_size =          "128"
   ephemeral_storage_size = "512"
 }

   module "ma-media-auth-service" {
   source               = "../lambda"
   create_layer = false
   lambda_function_name = "ma_media_auth_service" 
   s3_bucket          =  "./lambda_function.rb"
   s3_key_function_code = ""
   role                 = module.lambda_edge_cloudfront.role_arn
   runtime              = "nodejs18.x"
   handler              = "lambda_function.lambda_handler"
   memory_size =          "128"
   ephemeral_storage_size = "512"
 }


   module "add-origin-cache-control-lambda-funtion" {
   source               = "../lambda"
   create_layer = false
   lambda_function_name = "add-origin-cache-control-lambda-funtion" 
   s3_bucket          =  "cloudify-lambda-code"
   s3_key_function_code = "add-origin-cache-control-lambda-funtion.zip"
   role                 = module.lambda_edge_cloudfront.role_arn
   runtime              = "nodejs18.x"
   handler              = "lambda_function.lambda_handler"
   memory_size =          "128"
   ephemeral_storage_size = "512"
 }

  module "multi-s3-origin-request-lambda-function" {
   source               = "../lambda"
   create_layer = false
   lambda_function_name = "multi-s3-origin-request-lambda-function" 
   s3_bucket          =  "cloudify-lambda-code"
   s3_key_function_code = "multi-s3-origin-request-lambda-function.zip"
   role                 = module.lambda_edge_cloudfront.role_arn
   runtime              = "nodejs18.x"
   handler              = "lambda_function.lambda_handler"
   memory_size =          "128"
   ephemeral_storage_size = "512"
 }
