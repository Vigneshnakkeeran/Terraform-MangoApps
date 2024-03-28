# output "lambda_execution_role" {
#   description = "The ARN of the IAM role created for Lambda execution"
#   value       = aws_iam_role.lambda_execution_role.arn
# }

# output "lambda_arn" {
#   description = "The ARN of the Lambda function"
#   value       = aws_lambda_function.my_lambda[count.index]
# }

# output "function_arn" {
#   value = aws_lambda_function.my_lambda[count.index]
# }

output "lambda_function_arn" {
  description = "The ARN of the Lambda function."
  value       = aws_lambda_function.my_lambda.*.arn
  depends_on  = [aws_lambda_function.my_lambda]
}

output "lambda_function_qualified_arn" {
  description = "The ARN identifying your Lambda Function Version"
  value       = try(aws_lambda_function.my_lambda[0].qualified_arn, "")
}

output "lambda_layer_version_arn" {
  description = "The ARN of the Lambda layer version, if created."
  value       = length(aws_lambda_layer_version.lambda_layer) > 0 ? aws_lambda_layer_version.lambda_layer[0].arn : ""
  depends_on  = [aws_lambda_layer_version.lambda_layer]
}

# output "lambda_role_arn" {
#   description = "The ARN of the IAM role used by the Lambda function."
#   value       = var.role
# }

