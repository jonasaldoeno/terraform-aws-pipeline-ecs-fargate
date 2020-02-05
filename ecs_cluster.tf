module "cluster" {

  source = "./modules/ecs"

  vpc_id           = module.vpc.vpc_id
  cluster_name     = var.cluster_name
  target_group_arn = module.pedido.tg_arn

  enable_container_insights = true

   listener = {
     port            = 80
     protocol        = "HTTP"
  #   certificate_arn = var.certificate
  #   ssl_policy      = "ELBSecurityPolicy-TLS-1-2-2017-01" // Default "ELBSecurityPolicy-TLS-1-1-2017-01"
   }

  private_subnets = module.vpc.private_subnets
  public_subnets  = module.vpc.public_subnets
  tags            = var.tags
}
