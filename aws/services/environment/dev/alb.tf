# data "aws_acm_certificate" "mangoapp_cert" {
#   domain   = var.alb_certificate_domain_name
#   statuses = ["ISSUED"]
#   types       = ["AMAZON_ISSUED"]  #PRIVATE, IMPORTED
# }

# module "alb" {
#   source  = "../../../modules/alb"

#   name               = "${var.client_name}-${var.environment}-alb"
#   vpc_id             = module.vpc.vpc_id
#   subnets            = module.vpc.private_subnets
#   security_groups    = [module.alb_security_group.security_group_id]
#   internal           = var.internal 
#   ip_address_type    = var.ip_address_type 
#   load_balancer_type = var.load_balancer_type
#   enable_deletion_protection = var.enable_deletion_protection

#   listeners = {
#     redirect-http-https = {
#       port     = 80
#       protocol = "HTTP"
#       redirect = {
#         port        = "443"
#         protocol    = "HTTPS"
#         status_code = "HTTP_301"
#       }
#     }

#     https5223 = {
#       port            = 5223
#       protocol        = "HTTPS"
#       certificate_arn = data.aws_acm_certificate.mangoapp_cert.arn
#       forward = {
#         target_group_key = "server5223"
#       }
#     }

#     https443 = {
#       port            = 443
#       protocol        = "HTTPS"
#       certificate_arn = data.aws_acm_certificate.mangoapp_cert.arn
#       forward = {
#         target_group_key = "server443"
#       }

#       #listner rules
#       rules = var.listner_rule_https443_sync
#     }
#   }

#   #### Create Target Groups ####
#   target_groups = {  
#     ##### Target group for "MaUsTGAppServer443" for Autoscaling_group ####   
#     server443 = {            
#       name                              = "MaUsTGAppServer443"
#       protocol                          = "HTTPS"
#       protocol_version                  = "HTTP1"
#       port                              = 443
#       target_type                       = "instance"
#       deregistration_delay              = 5
#       load_balancing_algorithm_type     = "round_robin"
#       load_balancing_cross_zone_enabled = "use_load_balancer_configuration"

#       health_check = {
#         enabled             = true
#         interval            = 30
#         path                = "/healthcheck"
#         port                = 443
#         healthy_threshold   = 2
#         unhealthy_threshold = 5
#         timeout             = 5
#         protocol            = "HTTPS"
#         matcher             = "200-399"
#       }
#     }

# ######### Target group for "MaUsTGMsgServer5223" ###########  
#     server5223 = {
#       name                              = "MaUsTGMsgServer5223"
#       protocol                          = "HTTPS"
#       protocol_version                  = "HTTP1"
#       port                              = 5223
#       target_type                       = "instance"
#       deregistration_delay              = 5
#       load_balancing_algorithm_type     = "round_robin"
#       load_balancing_cross_zone_enabled = "use_load_balancer_configuration"

#       health_check = {
#         enabled             = true
#         interval            = 30
#         path                = "/healthcheck"
#         port                = 443 #"traffic-port"
#         healthy_threshold   = 5
#         unhealthy_threshold = 2
#         timeout             = 5
#         protocol            = "HTTPS"
#         matcher             = "200-399"
#       }
#     }
#   }

#   target_group_attachments = {
#     attach-ec2-5223target = {
#       target_group_key = "server5223"
#       target_type      = "instance"
#       target_id        = module.ec2_instance_target.id
#       port             = "5223"
#     }
#   }
# }



# ########################
# #ec2 module for target

# module "ec2_instance_target" {
#   source  = "../../../modules/ec2"

#   name = "single-instance"

#   instance_type          = "t2.micro"
#   key_name               = "user1"
#   vpc_security_group_ids = [module.bastion_security_group.security_group_id]
#   subnet_id              = module.vpc.private_subnets[0]
# }



