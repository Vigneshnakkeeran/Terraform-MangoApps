resource "aws_lambda_function" "my_lambda" {
  function_name = var.lambda_function_name
  filename      = var.source_path
  source_code_hash = filebase64sha256("${path.module}/lambda_function.zip")
  layer = aws_lambda_layer_version.lambda_layer.arn
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

 resource "aws_lambda_layer_version" "lambda_layer" {
  filename   =  var.lambda_layer_path    # "lambda_layer_payload.zip"
  layer_name = var.layer_name
  compatible_runtimes = ["ruby2.7"]
}
