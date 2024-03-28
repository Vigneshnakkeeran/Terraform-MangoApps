 module "my_lambda_module" {
   source               = "../lambda"
   create_layer = true
   s3_bucket          =  ""
   s3_key_function_code = ""
   lambda_function_name = "ses-lambda-function"  
   layer_name           = "ses-lambda-layer" 
#   layer_runtime        = ["nodejs18.x"]
   s3_key_layer         = "./layer.zip"
   role                 = module.ses_lambda_execution_role.role_arn
   runtime              = "ruby3.2"
   handler              = "lambda_function.lambda_handler"
   memory_size =          "128"
#   lambda_permission_source_arn = "arn:aws:ses:${data.aws_region.current.id}:${data.aws_caller_identity.current.account_id}:receipt-rule-set/*"
  environment_variables = {
    AWS_INCOMING_BUCKET = "hub-mangoapps-test-terraform-com"   
    AWS_REGION = "us-west-2"
    hub_mangoapps_test_terraform_com = "https://sqs.eu-west-1.amazonaws.com/760042596542/hub-mangoapps-test-terraform-com"
  }
#   ephemeral_storage_size = "512"
#   aws_region = "us-west-2"
#   aws_incoming_bucket = module.ses_s3.s3_bucket_id
#   debug_mode = ""
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
   s3_bucket          =  "./lambda_function.rb"
   s3_key_function_code = ""
#   layer_name           = "ses-lambda-layer"  
#   lambda_layer_path    = "./layer.zip"
   role                 = module.qaLamdaAdge-viewer-request_role.role_arn
   runtime              = "nodejs18.x"
   handler              = "lambda_function.lambda_handler"
   memory_size =          "128"
   ephemeral_storage_size = "512"
#   lambda_permission_source_arn = ""
#   aws_region = "us-west-2"
#   aws_incoming_bucket = module.ses_s3.s3_bucket_id
#   debug_mode = ""
 }

 module "qaLamdaAdge-viewer-response" {
   source               = "../lambda"
   create_layer = false
   lambda_function_name = "qaLamdaAdge-viewer-request" 
   s3_bucket          =  "./lambda_function.rb"
   s3_key_function_code = ""
   role                 = module.qaLamdaAdge-viewer-request_role.role_arn
   runtime              = "nodejs18.x"
   handler              = "lambda_function.lambda_handler"
   memory_size =          "128"
   ephemeral_storage_size = "512"
 }

  module "qaLamdaAdge-origin-request" {
   source               = "../lambda"
   create_layer = false
   lambda_function_name = "qaLamdaAdge-viewer-request" 
   s3_bucket          =  "./lambda_function.rb"
   s3_key_function_code = ""
   role                 = module.qaLamdaAdge-viewer-request_role.role_arn
   runtime              = "nodejs18.x"
   handler              = "lambda_function.lambda_handler"
   memory_size =          "128"
   ephemeral_storage_size = "512"
 }

