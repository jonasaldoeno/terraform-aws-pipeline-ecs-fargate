resource "aws_route53_record" "myapp" {
  zone_id = var.zone_id
  name    = var.app_name
  type    = "CNAME"
  ttl     = "1"

  weighted_routing_policy {
    weight = 10
  }

  set_identifier = var.app_name
  records        = [module.cluster.alb_dns_name]

  depends_on = [module.cluster.alb]
}
