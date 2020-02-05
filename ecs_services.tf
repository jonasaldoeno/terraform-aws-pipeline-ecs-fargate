module "front" {
  source = "./modules/service"
  vpc_id = module.vpc.vpc_id
  region = var.aws_region

  is_public = false

  # Service name
  service_name                = "front"
  service_base_path           = ["/front*"]
  service_alb_access          = true
  service_gateway_access      = false
  container_name              = format("%s-%s", var.cluster_name, "front")
  container_port              = 80
  container_port_health_check = 80

  service_launch_type = "FARGATE"

  service_healthcheck = {
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 10
    interval            = 30
    matcher             = "200"
    path                = "/"
    port                = 80
  }
  # service_environment = [
  #     {
  #     "name": "VOTES_API_URI",
  #     "value": "http://votes-api:3000"
  #
  #     },
  #     {
  #     "name": "REPORTS_API_URI",
  #     "value": "http://votes-reports:3000"
  #     }
  # ]

  # Cluster to deploy your service - see in clusters.tf
  cluster_name     = var.cluster_name
  cluster_id       = module.cluster.cluster_id
  cluster_listener = module.cluster.listener
  cluster_alb_sg   = module.cluster.alb_sg
  cluster_alb_arn  = module.cluster.alb

  # Auto Scale Limits
  desired_tasks = 2
  min_tasks     = 2
  max_tasks     = 10

  # Tasks CPU / Memory limits
  desired_task_cpu = 256
  desired_task_mem = 512

  # CPU metrics for Auto Scale
  cpu_to_scale_up         = 80
  cpu_to_scale_down       = 50
  cpu_verification_period = 60
  cpu_evaluation_periods  = 1

  # Pipeline Configuration
  build_image = "aws/codebuild/standard:2.0"

  git_repository_owner  = "jonaopower"
  git_repository_name   = "catalogo"
  git_repository_branch = "master"

  # AZ's
  private_subnets = module.vpc.private_subnets
  tags            = var.tags
}

module "pedido" {
  source = "./modules/service"
  vpc_id = module.vpc.vpc_id
  region = var.aws_region

  is_public = false

  # Service name
  service_name                = "pedido"
  service_base_path           = ["/api*", "/swagger*"]
  service_alb_access          = true
  service_gateway_access      = false
  container_name              = format("%s-%s", var.cluster_name, "pedido")
  container_port              = 80
  container_port_health_check = 80

  service_launch_type = "FARGATE"

  service_healthcheck = {
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 10
    interval            = 30
    matcher             = "200"
    path                = "/check"
    port                = 80
  }
  # service_environment = [
  #     {
  #     "name": "VOTES_API_URI",
  #     "value": "http://votes-api:3000"
  #
  #     },
  #     {
  #     "name": "REPORTS_API_URI",
  #     "value": "http://votes-reports:3000"
  #     }
  # ]

  # Cluster to deploy your service - see in clusters.tf
  cluster_name     = var.cluster_name
  cluster_id       = module.cluster.cluster_id
  cluster_listener = module.cluster.listener
  cluster_alb_sg   = module.cluster.alb_sg
  cluster_alb_arn  = module.cluster.alb

  # Auto Scale Limits
  desired_tasks = 2
  min_tasks     = 2
  max_tasks     = 10

  # Tasks CPU / Memory limits
  desired_task_cpu = 256
  desired_task_mem = 512

  # CPU metrics for Auto Scale
  cpu_to_scale_up         = 80
  cpu_to_scale_down       = 50
  cpu_verification_period = 60
  cpu_evaluation_periods  = 1

  # Pipeline Configuration
  build_image = "aws/codebuild/standard:2.0"

  git_repository_owner  = "jonaopower"
  git_repository_name   = "catalogo"
  git_repository_branch = "master"

  # AZ's
  private_subnets = module.vpc.private_subnets
  tags            = var.tags
}

