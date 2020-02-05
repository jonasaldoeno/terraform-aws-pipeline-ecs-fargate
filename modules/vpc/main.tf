module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name = var.name
  cidr = var.cidr

  azs             = var.azs
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_nat_gateway = var.enable_nat_gateway
  enable_vpn_gateway = var.enable_vpn_gateway
  single_nat_gateway  = var.single_nat_gateway
  reuse_nat_ips       = var.reuse_nat_ips       # <= Skip creation of EIPs for the NAT Gateways
  external_nat_ip_ids = var.external_nat_ip_ids   # <= IPs specified here as input to the module
  enable_dns_hostnames = true
  enable_dns_support   = true

}

