resource "aws_alb" "cluster_alb" {
  name            = format("%s-alb", var.cluster_name)
  subnets         = var.public_subnets
  security_groups = [aws_security_group.alb_sg.id]

  tags = var.tags
  
}
