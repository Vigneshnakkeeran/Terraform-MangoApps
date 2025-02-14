module "nlb" {
  source  = "../../../../modules/elb"

  name               = "${var.client_name}-${var.environment}-nlb"
  vpc_id             = module.vpc.vpc_id

  internal           = var.nlb_internal
  ip_address_type    = var.nlb_ip_address_type 
  load_balancer_type = var.nlb_load_balancer_type
  enable_deletion_protection       = var.nlb_enable_deletion_protection
  enable_cross_zone_load_balancing = var.nlb_enable_cross_zone_load_balancing

  subnet_mapping = [for i, eip in aws_eip.this :
    {
      allocation_id = eip.id
      subnet_id     = "${module.vpc.public_subnets[i]}"
    }
  ]

  listeners = {

    tcp80 = {
      port            = 80
      protocol        = "TCP"
      forward = {
        target_group_key = "TGALB80"
      }
    }

    tcp443 = {
      port            = 443
      protocol        = "TCP"
      forward = {
        target_group_key = "TGALB443"
      }
    }

    tcp5223 = {
      port            = 5223
      protocol        = "TCP"
      forward = {
        target_group_key = "TGALB5223"
      }
    }
  }

  #### Create Target Groups ####
  target_groups = {  
    ##### Target group for "MaTGALB80" ####   
    TGALB80 = {            
      name                              = "MaTGALB80"
      protocol                          = "TCP"
      port                              = 80
      target_type                       = "alb"
      deregistration_delay              = 5
      preserve_client_ip                = true

      health_check = {
        enabled             = true
        interval            = 30
        path                = "/healthcheck"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200-399"
      }
    }

######### Target group for "MaTGALB5223" ###########  
    TGALB5223 = {            
      name                              = "MaTGALB5223"
      protocol                          = "TCP"
      port                              = 5223
      target_type                       = "alb"
      deregistration_delay              = 5
      preserve_client_ip                = true

      health_check = {
        enabled             = true
        interval            = 30
        path                = "/healthcheck"
        port                = "443" #"traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 10
        protocol            = "HTTPS"
        matcher             = "200-399"
      }
    }

    ######### Target group for "MaTGALB443" ###########  
    TGALB443 = {            
      name                              = "MaTGALB443"
      protocol                          = "TCP"
      port                              = 443
      target_type                       = "alb"
      deregistration_delay              = 5
      preserve_client_ip                = true

      health_check = {
        enabled             = true
        interval            = 30
        path                = "/healthcheck"
        port                = "traffic-port"
        healthy_threshold   = 2
        unhealthy_threshold = 5
        timeout             = 5
        protocol            = "HTTPS"
        matcher             = "200-399"
      }
    }
  }

  target_group_attachments = {
    attach-alb-TGALB80 = {
      target_group_key = "TGALB80"
      target_type      = "alb"
      target_id        = module.alb.id
      port             = "80"
    }
    
    attach-alb-TGAL5223 = {
      target_group_key = "TGALB5223"
      target_type      = "alb"
      target_id        = module.alb.id
      port             = "5223"
    }

    attach-alb-TGALB443 = {
      target_group_key = "TGALB443"
      target_type      = "alb"
      target_id        = module.alb.id
      port             = "443"
    }

  }

  depends_on = [ module.alb ]
  
}

###################################################################
## EIP #####################

resource "aws_eip" "this" {
  count = 1
  domain = "vpc"

  tags = {
    Name = "${var.client_name}-${var.environment}-Nlb-Eip"
  }
}
