# data "archive_file" "lambda_function" {
#   type        = var.file_type
#   source_file = var.source_path
#   output_path = "lambda_function.zip"
# }

# resource "aws_lambda_permission" "lambda_permission" {
#   statement_id  = "AllowSESLambdaInvocation"
#   action        = "lambda:InvokeFunction"
#   function_name = var.lambda_permission_function_name  # Corrected reference
#   principal     = "ses.amazonaws.com"
#   source_arn    = var.lambda_permission_source_arn  #module.ses_email.ses_receipt_rule_arn
                  
# }

locals {
  create = var.create
}

resource "aws_lambda_function" "my_lambda" {
  count = local.create && var.create_function && !var.create_layer ? 1 : 0
  function_name = var.lambda_function_name
  s3_bucket      = var.s3_bucket
  s3_key         = var.s3_key_function_code
  # source_code_hash = filebase64sha256(data.archive_file.lambda_function.output_path)
  layers = length(aws_lambda_layer_version.lambda_layer) > 0 ? [aws_lambda_layer_version.lambda_layer[0].arn] : []
  runtime = var.runtime
  handler = var.handler
  role    = var.role
  memory_size = var.memory_size
  /* ephemeral_storage is not supported in gov-cloud region, so it should be set to `null` */
  dynamic "ephemeral_storage" {
    for_each = var.ephemeral_storage_size == null ? [] : [true]

    content {
      size = var.ephemeral_storage_size
    }
  }

  dynamic "environment" {
    for_each = length(keys(var.environment_variables)) == 0 ? [] : [true]
    content {
      variables = var.environment_variables
    }
  }
}

resource "aws_lambda_alias" "lambda_version_alias" {
  count = length(aws_lambda_function.my_lambda) > 0 ? 1 : 0
#  count         = local.create && var.create_function ? 1 : 0
  name          = "virsion_1"
  function_name = aws_lambda_function.my_lambda[0].function_name
  function_version = "v1"
}

 resource "aws_lambda_layer_version" "lambda_layer" {
  count = local.create && var.create_layer ? 1 : 0
  s3_bucket   =  var.s3_bucket
  s3_key      =  var.s3_key_layer
  layer_name =   var.layer_name
  compatible_runtimes = length(var.compatible_runtimes) > 0 ? var.compatible_runtimes : (var.runtime == "" ? null : [var.runtime])
}
