# # module "iam_role_with_policies" {
# #   source = "./../../../../aws/modules/IAM-Role"

# #   role_name           = "example-role"
# #   assume_role_policy  = jsonencode({
# #     Version = "2012-10-17"
# #     Statement = [
# #       {
# #         Action = "sts:AssumeRole"
# #         Effect = "Allow"
# #         Principal = {
# #           Service = "ec2.amazonaws.com"
# #         }
# #       },
# #     ]
# #   })
# #   managed_policy_arns = ["arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"]
# #   custom_policy_name  = "example-custom-policy"
# #   custom_policy       = <<EOF
# # {
# #   "Version": "2012-10-17",
# #   "Statement": [
# #     {
# #       "Effect": "Allow",
# #       "Action": "logs:CreateLogGroup",
# #       "Resource": "*"
# #     }
# #   ]
# # }
# # EOF
# # }

################### LAMBDA FUNCTION EXECUTION ROLE ####################

module "ses_lambda_execution_role" {
   source = "../IAM-Role"
   role_name           = "ses_lambda_execution_role"
   assume_role_policy = jsonencode({
     Version = "2012-10-17"
     Statement = [
       {
         Action = "sts:AssumeRole"
         Effect = "Allow"
         Principal = {
           Service = [ "lambda.amazonaws.com"
           ]
         }
       },
     ]
   })
#   managed_policy_arns = ["arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"]
   custom_policy_name  = "lambda-ses-custom-policy"
   custom_policy       = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogStream",
                "logs:CreateLogGroup",
                "logs:PutLogEvents"
            ],
            "Resource": "*"
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": [
                "s3:GetObject",
                "ses:SendRawEmail",
                "sqs:ReceiveMessage",
                "sqs:DeleteMessage",
                "sqs:GetQueueAttributes"
            ],
            "Resource": [
              "arn:aws:s3:::${var.client_name}-${var.environment}-ses-bucket/*",
              "arn:aws:sqs:us-west-2:730335460835:*",
              "arn:aws:ses:us-west-2:730335460835:identity/*"
            ]
        }
    ]
}
 EOF
}

module "lambda_edge_cloudfront" {
   source = "../IAM-Role"
   role_name           = "lambda_edge_cloudfront_role"
   assume_role_policy = jsonencode({
     Version = "2012-10-17"
     Statement = [
       {
         Action = "sts:AssumeRole"
         Effect = "Allow"
         Principal = {
           Service = ["lambda.amazonaws.com",
                    "edgelambda.amazonaws.com"]
         }
       },
     ]
   })
#   managed_policy_arns = ["arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"]
   custom_policy_name  = "lambda_edge_cloudfront_policy"
   custom_policy       = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": "*"
        }
    ]
}
 EOF
}
