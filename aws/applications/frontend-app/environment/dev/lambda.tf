
################## Lambda for delete_custom_images #################

 module "delete_custom_images_lambda_module" {

  source = "../../../../modules/lambda"

  create_package  = false   

  s3_existing_package = {
     bucket = "cloudify-lambda-code"
     key    = "delete_custom_images.zip"
  }

  lambda_role = module.lambda_execution_role_ssm.role_arn
  
   function_name          = "delete_custom_images"
   runtime                = "python3.9"
   handler                = "lambda_function.lambda_handler"
   memory_size            = "128"
   timeout                = "300"

  publish = true
  environment_variables = {
    AWS_INSTANCE_ID = "${data.terraform_remote_state.Statefile.outputs.ec2_frontendserver_id}"  
  }
 }


################## Lambda for update_launch_template #################

 module "update_launch_template_lambda_module" {

  source = "../../../../modules/lambda"

  create_package         = false   
  # local_existing_package = "${path.module}/../zip/lambda_package.zip"


  s3_existing_package = {
     bucket = "cloudify-lambda-code"
     key    = "update_launch_template.zip"
  }

  environment_variables = {
    asg_name = "${var.client_name}-${var.environment}-asg"
    region   = "${data.aws_region.current.name}"
    launch_template_id = "${module.asg.launch_template_id}" 
  }  

  lambda_role = module.lambda_execution_role_ssm.role_arn
  
   function_name        = "update_launch_template"
   runtime              = "python3.9"
   handler              = "lambda_function.lambda_handler"
   memory_size          = "128"
   timeout              = "300"

  publish = true

 }