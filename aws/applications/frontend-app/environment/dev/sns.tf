module "cw_asg_alarm_sns_topic" {
  source  = "../../../../modules/sns"
  name  = "cw-asg-alarm"
  enable_default_topic_policy = true
  subscriptions = {
    email = {
      protocol = "email"
      endpoint = "rohith.balarama@cloudifyops.com"
    }
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}