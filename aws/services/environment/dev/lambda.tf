module "my_lambda_module" {
  source               = "./my-lambda-module"
  lambda_function_name = "my-lambda-function"
  role                 = module.lambda_execution_role.arn
  runtime              = "python3.8"
  handler              = "index.handler"
  memory_size =          ""
  ephemeral_storage_size = ""
}
