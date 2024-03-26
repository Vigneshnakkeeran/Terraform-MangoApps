 module "my_lambda_module" {
   source               = "../../../../modules/lambda"
   source_path          =  "./lambda_function.rb"
   lambda_function_name = "ses-lambda-function"  
   layer_name           = "ses-lambda-layer"  
   lambda_layer_path    = "./layer.zip"
   role                 = module.lambda_execution_role.role_arn
   runtime              = "ruby3.2"
   handler              = "lambda_function.lambda_handler"
   memory_size =          "128"
   ephemeral_storage_size = "512"
#   aws_region = "us-west-2"
   aws_incoming_bucket = module.ses_s3.s3_bucket_id
#   debug_mode = ""
 }


 resource "aws_lambda_permission" "ses_lambda_permission" {
  statement_id  = "AllowSESLambdaInvocation"
  action        = "lambda:InvokeFunction"
  function_name = module.my_lambda_module.function_arn  # Corrected reference
  principal     = "ses.amazonaws.com"
  source_arn    = "arn:aws:ses:${data.aws_region.current.id}:${data.aws_caller_identity.current.account_id}:receipt-rule-set/*"  #module.ses_email.ses_receipt_rule_arn
                  
}
