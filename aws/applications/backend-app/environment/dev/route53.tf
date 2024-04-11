module "records" {
  source = "../../../../modules/route53/records"
  zone_id = var.zone_id

  records = [
    {
      name = "hub"
      type = "A"
      ttl  = 600
      records = [aws_eip.this[0].public_ip]
    }, 
  ]
}