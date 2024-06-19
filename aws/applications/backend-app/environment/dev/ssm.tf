module "ssm_maintenance" {
  source = "../../../../modules/ssm"
  
  parameter_name        = "my-parameter"
  parameter_type        = "String"
  parameter_value       = "ami-02f0f3474e47134b3"
  parameter_description = "My SSM Parameter"

  document_name         = "my-automation-document"
  document_content      = <<EOF
---
description: Creates a new Amazon Machine Image (AMI) from an Amazon EC2 instance.
schemaVersion: '0.3'
assumeRole: '{{ AutomationAssumeRole }}'
outputs:
  - createImage.ImageId
parameters:
  InstanceId:
    type: String
    description: '(Required) The ID of the Amazon EC2 instance.'
    default: ${module.ec2_frontendserver.id}
  NoReboot:
    type: Boolean
    description: '(Optional) Do not reboot the instance before creating the image.'
    default: true
  AutomationAssumeRole:
    type: String
    description: '(Optional) The ARN of the role that allows Automation to perform the actions on your behalf.'
    default: 'arn:aws:iam::aws-account-id:role/ssm_automation_ami_creation'
  ParameterName:
    type: String
    description: '(Required) The name of the SSM parameter store value to update.'
    default: oregon_image_id
  ParameterValue:
    type: String
    description: '(Required) The new value to set for the SSM parameter store value.'
    default: ami-0dcd9e2f1f1d58966
  LambdaUpdateLT:
    type: String
    description: '(Optional) The new value to set for the SSM parameter store value.'
    default: update_launch_template
  LambdaDeleteAMI:
    type: String
    description: '(Optional) The new value to set for the SSM parameter store value.'
    default: delete_custom_images
mainSteps:
  - action: 'aws:invokeLambdaFunction'
    name: Deletelambda
    timeoutSeconds: 1200
    maxAttempts: 1
    onFailure: Abort
    inputs:
      FunctionName: '{{LambdaDeleteAMI}}'
  - name: createImage
    action: 'aws:createImage'
    timeoutSeconds: 2400
    onFailure: Abort
    inputs:
      InstanceId: '{{ InstanceId }}'
      ImageName: '{{ InstanceId }}_{{automation:EXECUTION_ID}}'
      NoReboot: '{{ NoReboot }}'
  - name: UpdateParameter
    action: 'aws:executeAwsApi'
    inputs:
      Service: ssm
      Api: PutParameter
      Name: '{{ ParameterName }}'
      Value: '{{ createImage.ImageId }}'
      Type: String
      Overwrite: true
  - action: 'aws:invokeLambdaFunction'
    name: InvokeLambdaFunction
    timeoutSeconds: 1200
    maxAttempts: 1
    onFailure: Abort
    inputs:
      FunctionName: '{{LambdaUpdateLT}}' 
EOF

  window_name                 = "my-maintenance-window"
  window_schedule             = "cron(0 2 ? * 5 *)"
  window_duration             = 3
  window_cutoff               = 1
  window_description          = "My Maintenance Window"
  task_type            = "AUTOMATION"
  # task_priority        = 1
  # max_concurrency      = "1"
  # max_errors           = "1"
  task_description     = "My Maintenance Window Task"
  document_version = "1"
}
