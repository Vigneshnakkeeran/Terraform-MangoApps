

################### LAMBDA FUNCTION EXECUTION ROLE ####################

module "ses_lambda_execution_role" {
   source = "../../../../modules/IAM/IAM-Role"
   role_name           = "ses_lambda_execution_role_01"
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
   custom_policy_name  = "lambda-ses-custom-policy-01"
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
              "arn:aws:s3:::cloudifyops-dev-ses-bucket/*",
              "arn:aws:sqs:us-west-2:730335460835:*",
              "arn:aws:ses:us-west-2:730335460835:identity/*"
            ]
        }
    ]
}
 EOF
}

############## LAMBDA EXECUTION ROLE FOR SSM IAMGE UPDATE AND DELETE ########################

module "lambda_execution_role_ssm" {
   source = "../../../../modules/IAM/IAM-Role"
   role_name           = "lambda_execution_role_ssm_image_update_delete"
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
   custom_policy_name  = "lambda-ssm-custom-policy"
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
                "ec2:DeregisterImage",
                "ec2:DescribeLaunchTemplates",
                "ssm:GetParameterHistory",
                "ec2:DescribeLaunchTemplateVersions",
                "ec2:RunInstances",
                "ssm:GetParameters",
                "autoscaling:*",
                "ssm:GetParameter",
                "ssm:DeleteParameters",
                "ec2:CreateLaunchTemplateVersion",
                "ssm:PutParameter",
                "ec2:DescribeImages",
                "iam:PassRole",
                "ssm:DeleteParameter",
                "ec2:CreateLaunchTemplate",
                "ssm:GetParametersByPath",
                "ec2:ModifyLaunchTemplate",
                "ec2:DeleteSnapshot",
                "ec2:CreateTags",
                "ec2:CreateImage",
                "ec2:DescribeSnapshots"
            ],
            "Resource": [
              "*"
            ]
        }
    ]
}
 EOF
}





################ LAMBDA EXECUTION ROLE FOR CLOUDFRONT ###################################

module "lambda_edge_cloudfront" {
   source = "../../../../modules/IAM/IAM-Role"
   role_name           = "lambda_edge_cloudfront_role_01"
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
   custom_policy_name  = "lambda_edge_cloudfront_policy-01"
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


############################ SSM Automation Role ############################

module "ssm_document_execution_role" {
   source = "../../../../modules/IAM/IAM-Role"
   role_name           = "ssm_automation_ami_creation"
   assume_role_policy = jsonencode({
     Version = "2012-10-17"
     Statement = [
       {
         Action = "sts:AssumeRole"
         Effect = "Allow"
         Principal = {
           Service = [ 
                    "ec2.amazonaws.com",
                    "ssm.amazonaws.com"            
           ]
         }
       },
     ]
   })
   managed_policy_arns = ["arn:aws:iam::aws:policy/service-role/AmazonSSMMaintenanceWindowRole"]
   custom_policy_name  = "lambda_invoke"
   custom_policy       = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "ssm:PutParameter",               
				        "iam:PassRole",                
			        	"ssm:DeleteParameter",                
			        	"ssm:DescribeParameters",                
			        	"lambda:InvokeFunction",                
			        	"ssm:DescribeDocumentParameters",                
			        	"ec2:CreateImage",                
			        	"ssm:GetParameters",                
			        	"ssm:GetParameter",                
			        	"ssm:DeleteParameters",                
			        	"ec2:DescribeImages"
            ],
            "Resource": "*"
        }
    ]
}
 EOF
}