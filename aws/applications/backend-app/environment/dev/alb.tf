 data "aws_acm_certificate" "mangoapp_cert" {
   domain   = var.alb_certificate_domain_name
   statuses = ["ISSUED"]
   types       = ["AMAZON_ISSUED"] 
 }

 module "alb" {
   source  = "../../../../modules/elb"

   name               = "${var.client_name}-${var.environment}-alb"
   vpc_id             = module.vpc.vpc_id
   subnets            = module.vpc.private_subnets
   security_groups    = [module.alb_security_group.security_group_id]
   internal           = var.internal 
   ip_address_type    = var.ip_address_type 
   load_balancer_type = var.load_balancer_type
   enable_deletion_protection = var.enable_deletion_protection

   listeners = {
     redirect-http-https = {
       port     = 80
       protocol = "HTTP"
       redirect = {
         port        = "443"
         protocol    = "HTTPS"
         status_code = "HTTP_301"
       }
     }

     https5223 = {
       port            = 5223
       protocol        = "HTTPS"
       certificate_arn = data.aws_acm_certificate.mangoapp_cert.arn
       forward = {
         target_group_key = "server5223"
       }
       rules  =  var.listner_rule_https5223
     } 

     https443 = {
       port            = 443
       protocol        = "HTTPS"
       certificate_arn = data.aws_acm_certificate.mangoapp_cert.arn
       forward = {
         target_group_key = "server443"
       }

       #listner rules
       rules = var.listner_rule_https443_sync
     }  
   }

   #### Create Target Groups ####
   target_groups = {  
     ##### Target group for "MaUsTGAppServer443" for Autoscaling_group ####   
     server443 = {            
       name                              = "TGAppServer443"
       protocol                          = "HTTPS"
       protocol_version                  = "HTTP1"
       port                              = 443
       target_type                       = "instance"
       deregistration_delay              = 5
       load_balancing_algorithm_type     = "round_robin"
       load_balancing_cross_zone_enabled = "use_load_balancer_configuration"

       health_check = {
         enabled             = true
         interval            = 30
         path                = "/healthcheck"
         port                = "traffic-port" #443
         healthy_threshold   = 2
         unhealthy_threshold = 5
         timeout             = 5
         protocol            = "HTTPS"
         matcher             = "200"
       }
     }

 ######### Target group for "TGMsgServer5223" ###########  
     server5223 = {
       name                              = "TGMsgServer5223"
       protocol                          = "HTTPS"
       protocol_version                  = "HTTP1"
       port                              = 5223
       target_type                       = "instance"
       deregistration_delay              = 5
       load_balancing_algorithm_type     = "round_robin"
       load_balancing_cross_zone_enabled = "use_load_balancer_configuration"

       health_check = {
         enabled             = true
         interval            = 30
         path                = "/healthcheck"
         port                = 443 #"traffic-port"
         healthy_threshold   = 5
         unhealthy_threshold = 2
         timeout             = 5
         protocol            = "HTTPS"
         matcher             = "200"
       }
     }

    ######### Target group for "TGBgServer8008" ###########  
     server8008 = {
       name                              = "TGBgServer8008"
       protocol                          = "HTTPS"
       protocol_version                  = "HTTP1"
       port                              = 8008
       target_type                       = "instance"
       deregistration_delay              = 5
       load_balancing_algorithm_type     = "round_robin"
       load_balancing_cross_zone_enabled = "use_load_balancer_configuration"

       health_check = {
         enabled             = true
         interval            = 30
         path                = "/healthcheck"
         port                = 443 #"traffic-port"
         healthy_threshold   = 5
         unhealthy_threshold = 2
         timeout             = 5
         protocol            = "HTTPS"
         matcher             = "200"
       }
     }

    ######### Target group for "TGBgServer8080" ###########  
     server8080 = {
       name                              = "TGBgServer8080"
       protocol                          = "HTTPS"
       protocol_version                  = "HTTP1"
       port                              = 8080
       target_type                       = "instance"
       deregistration_delay              = 5
       load_balancing_algorithm_type     = "round_robin"
       load_balancing_cross_zone_enabled = "use_load_balancer_configuration"

       health_check = {
         enabled             = true
         interval            = 30
         path                = "/healthcheck"
         port                = 443 #"traffic-port"
         healthy_threshold   = 5
         unhealthy_threshold = 2
         timeout             = 5
         protocol            = "HTTPS"
         matcher             = "200"
       }
     }
     
    ######### Target group for "TGBgServer9001" ###########  
     server9001 = {
       name                              = "TGBgServer9001"
       protocol                          = "HTTPS"
       protocol_version                  = "HTTP1"
       port                              = 9001
       target_type                       = "instance"
       deregistration_delay              = 5
       load_balancing_algorithm_type     = "round_robin"
       load_balancing_cross_zone_enabled = "use_load_balancer_configuration"

       health_check = {
         enabled             = true
         interval            = 30
         path                = "/healthcheck"
         port                = 443 #"traffic-port"
         healthy_threshold   = 5
         unhealthy_threshold = 2
         timeout             = 5
         protocol            = "HTTPS"
         matcher             = "200"
       }
     }

    ######### Target group for "TGBgServer9000" ###########  
     server9000 = {
       name                              = "TGBgServer9000"
       protocol                          = "HTTPS"
       protocol_version                  = "HTTP1"
       port                              = 9000
       target_type                       = "instance"
       deregistration_delay              = 5
       load_balancing_algorithm_type     = "round_robin"
       load_balancing_cross_zone_enabled = "use_load_balancer_configuration"

       health_check = {
         enabled             = true
         interval            = 30
         path                = "/healthcheck"
         port                = 443 #"traffic-port"
         healthy_threshold   = 5
         unhealthy_threshold = 2
         timeout             = 5
         protocol            = "HTTPS"
         matcher             = "200"
       }
     }     
   }

   target_group_attachments = {
     attach-ec2-443target = {
       target_group_key = "server443"
       target_type      = "instance"
       target_id        = module.ec2_frontendserver.id
       port             = "443"
     }    
     attach-ec2-5223target = {
       target_group_key = "server5223"
       target_type      = "instance"
       target_id        = module.ec2_backendserver.id
       port             = "5223"
     }
     attach-ec2-8008target = {
       target_group_key = "server8008"
       target_type      = "instance"
       target_id        = module.ec2_backendserver.id
       port             = "8008"
     }
     attach-ec2-8080target = {
       target_group_key = "server8080"
       target_type      = "instance"
       target_id        = module.ec2_backendserver.id
       port             = "8080"
     }
     attach-ec2-9001target = {
       target_group_key = "server9001"
       target_type      = "instance"
       target_id        = module.ec2_backendserver.id
       port             = "9001"
     } 
     attach-ec2-9000target = {
       target_group_key = "server9000"
       target_type      = "instance"
       target_id        = module.ec2_backendserver.id
       port             = "9000"
     }           
   }
}



