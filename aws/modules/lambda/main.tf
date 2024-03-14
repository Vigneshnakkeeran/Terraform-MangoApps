resource "aws_lambda_function" "my_lambda" {
  function_name = var.lambda_function_name
  filename      = "${path.module}/lambda_function.zip"
  source_code_hash = filebase64sha256("${path.module}/lambda_function.zip")

  runtime = var.runtime
  handler = var.handler
  role    = var.role
  memory_size = var.memory_size
  ephemeral_storage {
    size = var.ephemeral_storage_size # Min 512 MB and the Max 10240 MB
  }

  environment {
    variables = {
      EXAMPLE_VARIABLE = "exampleValue"
    }
  }
}
