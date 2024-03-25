 module "my_lambda_module" {
   source               = "../../../../modules/lambda"
   source_path          =  "./lambda_function.rb"
   lambda_function_name = "ses-lambda-function"  
   layer_name           = "ses-lambda-layer"  
   lambda_layer_path    = "./layer.zip"
   role                 = module.lambda_execution_role.role_arn
   runtime              = "ruby3.2"
   handler              = "index.handler"
   memory_size =          "128"
   ephemeral_storage_size = "512"
 }
