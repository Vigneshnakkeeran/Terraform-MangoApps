module "ec2_metric_alarms" {
  source  = "../../../../modules/cloudwatch/metric-alarms-by-multiple-dimensions"

  alarm_name          = "instance-cpu-alarm"
  alarm_description   = "ec2 cpuutilization"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 6
  threshold           = 30
  unit                = "Percent"
  datapoints_to_alarm = 1
 
  metric_name    = "CPUUtilization"
  namespace      = "AWS/EC2"
  period         = 300
  statistic      = "Average"

  dimensions = {
    "Instance1" = {
      InstanceId  = "i-0702dc8db1a4a7b90"
    }
  }

  alarm_actions = [module.cw_sns_topic.topic_arn]
}

module "demo_ec2_metric_alarms" {
  source  = "../../../../modules/cloudwatch/metric-alarms-by-multiple-dimensions"

  create_metric_alarm = true
  alarm_name          = "RDS CPU Utilization"
  alarm_name_delimiter = "-"
  alarm_description   = "Alarm when CPU exceeds threshold"
  actions_enabled     = true

  alarm_actions             = [module.cw_sns_topic.topic_arn]

  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  threshold           = 95
  unit                = "Percent"
  datapoints_to_alarm = 1

  dimensions = {
    "DBClusterIdentifier" = {
      DBClusterIdentifier  = "cloudifyops-dev-aurora01"
    }
  }
  metric_name    = "CPUUtilization"
  namespace      = "AWS/RDS"
  period         = 300
  statistic      = "Average"

  tags = {
    Environment = "dev"
  }
}
