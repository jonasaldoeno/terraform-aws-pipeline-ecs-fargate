resource "aws_security_group" "service_sg" {
  name        = format("%s-%s-sg", var.cluster_name, var.service_name)
  description = format("%s-%s", var.cluster_name, var.service_name)

  vpc_id = var.vpc_id

  ingress {
    from_port       = var.container_port_health_check
    to_port         = var.container_port_health_check
    protocol        = "tcp"
    security_groups = [var.cluster_alb_sg]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}

#resource "aws_security_group_rule" "service_health_check_sg_rule" {
#  security_group_id        = aws_security_group.service_sg.id
#  type                     = "ingress"
#  from_port                = var.container_port_health_check
#  to_port                  = 443
#  source_security_group_id = var.cluster_alb_sg
#  protocol                 = "tcp"
#}

resource "aws_security_group_rule" "service_alb_access_sg_rule" {
  security_group_id        = aws_security_group.service_sg.id
  count                    = var.service_alb_access ? 1 : 0
  type                     = "ingress"
  from_port                = var.container_port
  to_port                  = 443
  source_security_group_id = var.cluster_alb_sg
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "service_gateway_access_sg_rule" {
  security_group_id        = aws_security_group.service_sg.id
  count                    = var.service_gateway_access ? 1 : 0
  type                     = "ingress"
  from_port                = var.container_port
  to_port                  = var.container_port
  source_security_group_id = var.service_gateway_sg
  protocol                 = "tcp"
}
