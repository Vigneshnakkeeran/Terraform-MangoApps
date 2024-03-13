resource "aws_lambda_function" "my_lambda" {
  function_name = var.lambda_function_name
  filename      = "${path.module}/lambda_function.zip"
  source_code_hash = filebase64sha256("${path.module}/lambda_function.zip")

  runtime = var.runtime
  handler = var.handler
  role    = var.role
#  memory_size = var.memory_size

  environment {
    variables = {
      EXAMPLE_VARIABLE = "exampleValue"
    }
  }
}
