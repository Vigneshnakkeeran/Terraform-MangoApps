 module "my_lambda_module" {
   source               = "./my-lambda-module"
   lambda_function_name = "ses-lambda-function"
   role                 = module.lambda_execution_role.arn
   runtime              = "python3.8"
   handler              = "index.handler"
   memory_size =          "128"
   ephemeral_storage_size = "512"
 }
