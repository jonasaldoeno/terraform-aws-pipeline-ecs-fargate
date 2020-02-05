resource "aws_ecs_service" "service" {
  name            = format("%s-%s-srv", var.cluster_name, var.service_name)
  task_definition = aws_ecs_task_definition.task.arn
  cluster         = var.cluster_id
  desired_count   = var.desired_tasks

  launch_type     = var.service_launch_type

  network_configuration {
    security_groups  = [aws_security_group.service_sg.id]
    subnets          = var.private_subnets
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.tg.id
    container_name   = var.container_name
    container_port   = var.container_port
  }

  lifecycle {
    ignore_changes = [desired_count, task_definition]
  }

  platform_version  = var.platform_version

  depends_on = [aws_alb_target_group.tg]
#  depends_on = [aws_alb_listener.Default]

  #tags = var.tags
}
