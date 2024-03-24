#  module "my_lambda_module" {
#    source               = "./my-lambda-module"
#    source_path          =  ./lambda_function.rb
#    lambda_function_name = "ses-lambda-function"  
#    layer_name           = "ses-lambda-layer"  
#    lambda_layer_path    = "./layer.zip"
#    role                 = module.lambda_execution_role.arn
#    runtime              = "ruby2.7"
#    handler              = "index.handler"
#    memory_size =          "128"
#    ephemeral_storage_size = "512"
#  }
