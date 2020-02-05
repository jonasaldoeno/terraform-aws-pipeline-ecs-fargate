resource "aws_alb_listener" "default" {

  load_balancer_arn = aws_alb.cluster_alb.arn

  port            = lookup(var.listener, "port", "")
  protocol        = lookup(var.listener, "protocol", "HTTP")
  #certificate_arn = lookup(var.listener, "certificate_arn", "")

  default_action {
    type             = "forward"
    target_group_arn = var.target_group_arn
  }
  # default_action {
  #   type = "fixed-response"

  #   fixed_response {
  #     content_type = "text/plain"
  #     message_body = "Ops. Temos um problema."
  #     status_code  = "200"
  #   }
  # }

  depends_on = [var.target_group_arn]

}
