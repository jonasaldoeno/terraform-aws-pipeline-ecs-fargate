module "vpc" {
  source = "./modules/vpc"
  name   = var.cluster_name

  cidr = "10.0.0.0/16"

  azs             = ["sa-east-1a", "sa-east-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_nat_gateway  = true
  enable_vpn_gateway  = false
  single_nat_gateway  = true
  reuse_nat_ips       = true # <= Skip creation of EIPs for the NAT Gateways
  external_nat_ip_ids = module.vpc.eip

}
