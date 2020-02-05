variable "vpc_id" {}

variable "region" {}

variable "cluster_listener" {}

variable "cluster_alb_arn" {}

variable "cluster_alb_sg" {}

variable "cluster_name" {}

variable "cluster_id" {}

variable "service_name" {}

variable "service_protocol" { default = "http" }

variable "service_alb_access" { default = false }

variable "service_gateway_sg" { default = "" }

variable "service_gateway_access" { default = false }

variable "service_launch_type" {
  default = "FARGATE"
}
variable "service_environment" { default = [] }

variable "is_public" { default = true }

variable "platform_version" {
    default = "1.3.0"
}

variable "cpu_evaluation_periods" {
    default = 5
}

variable "service_healthcheck" {
  type        = map
  default = {
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 10
    interval            = 30
    matcher             = "200"
    path                = "/check"
    port                = 8080
  }
}
variable "container_name" {
  description = "Container name"
}

variable "container_port" {}

variable "container_port_health_check" {}

variable "desired_tasks" {}

variable "min_tasks" {}

variable "max_tasks" {}

variable "desired_task_cpu" {}

variable "desired_task_mem" {}

variable "cpu_to_scale_up" {}

variable "cpu_to_scale_down" {}

variable "cpu_verification_period" {}

variable "build_image" {}

variable "service_base_path" {
  type = list
}

variable "private_subnets" {}

variable "git_repository_owner" {}

variable "git_repository_name" {}

variable "git_repository_branch" {
  description = "Build branch aka Master"
}

variable "tags" {}
