module "cloudwatch_alarm_avg_cpu_30_for_30_min" {
  source = "../../../../modules/cloudwatch/cw-metric-alarms"

  alarm_name                = "oregon_dc_avg_cpu_30_for_30_min"
  comparison_operator       = "LessThanOrEqualToThreshold"
  evaluation_periods        = 1
  alarm_description         = "This metric monitors EC2 CPU utilization"
  actions_enabled           = true
  threshold                 = 30
  insufficient_data_actions = []

  alarm_actions = [
    module.asg.autoscaling_policy_arns["scale_down"], module.cw_asg_alarm_sns_topic.topic_arn
  ]

  metric_query = [{
    id = "e1"

    expression  = "AVG(METRICS())"
    label       = "Expression1 (CPUUtilization)"
    return_data = true
    }, {
    id = "m1"

    metric = [{
        metric_name = "CPUUtilization"
        namespace   = "AWS/EC2"
        period      = 1800
        stat        = "Average"
        unit        = "Percent"
        dimensions  = {
          InstanceId = data.terraform_remote_state.Statefile.outputs.ec2_frontendserver_id
        }
    }]
    }, {
    id = "m2"

    metric = [{
        metric_name = "CPUUtilization"
        namespace   = "AWS/EC2"
        period      = 1800
        stat        = "Average"
        unit        = "Percent"
        dimensions  = {
          InstanceId = data.terraform_remote_state.Statefile.outputs.ec2_backendserver_id
        }
    }]
  },{
    id = "m3"

    metric = [{
        metric_name = "CPUUtilization"
        namespace   = "AWS/EC2"
        period      = 1800
        stat        = "Average"
        unit        = "Percent"
        dimensions  = {
          InstanceId = data.terraform_remote_state.Statefile.outputs.ec2_frontendserver_02
        }
    }]
  }]
}

module "cloudwatch_alarm_high_cpu_utilization_ASG_Triggered" {
  source = "../../../../modules/cloudwatch/cw-metric-alarms"

  alarm_name                = "oregon_dc_high_cpu_utilization_(ASG_Triggered)"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = 1
  alarm_description         = "This metric monitors EC2 CPU utilization"
  actions_enabled           = true
  threshold                 = 70
  insufficient_data_actions = []

  alarm_actions = [
    module.asg.autoscaling_policy_arns["scale_up"], module.cw_asg_alarm_sns_topic.topic_arn
  ]

  metric_query = [{
    id = "e1"

    expression  = "AVG(METRICS())"
    label       = "Expression1 (CPUUtilization)"
    return_data = true
    }, {
    id = "m1"

    metric = [{
        metric_name = "CPUUtilization"
        namespace   = "AWS/EC2"
        period      = 60
        stat        = "Average"
        unit        = "Percent"
        dimensions  = {
          InstanceId = data.terraform_remote_state.Statefile.outputs.ec2_frontendserver_id
        }
    }]
    }, {
    id = "m2"

    metric = [{
        metric_name = "CPUUtilization"
        namespace   = "AWS/EC2"
        period      = 60
        stat        = "Average"
        unit        = "Percent"
        dimensions  = {
          InstanceId = data.terraform_remote_state.Statefile.outputs.ec2_backendserver_id
        }
    }]
  },{
    id = "m3"

    metric = [{
        metric_name = "CPUUtilization"
        namespace   = "AWS/EC2"
        period      = 60
        stat        = "Average"
        unit        = "Percent"
        dimensions  = {
          InstanceId = data.terraform_remote_state.Statefile.outputs.ec2_frontendserver_02
        }
    }]
  }]
}