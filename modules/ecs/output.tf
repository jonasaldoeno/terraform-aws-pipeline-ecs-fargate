output "cluster_id" {
  value = aws_ecs_cluster.cluster.id
}

output "alb" {
  value = aws_alb.cluster_alb.arn
}

output "alb_dns_name" {
  value = aws_alb.cluster_alb.dns_name 
}

output "listener" {
  value = aws_alb_listener.default.arn
}

output "alb_sg" {
  value = aws_security_group.alb_sg.id
}
