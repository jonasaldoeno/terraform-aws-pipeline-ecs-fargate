output "service_sg" {
  value = aws_security_group.service_sg.id
}

output "tg_name" {
  value = aws_alb_target_group.tg.name
}

output "tg_arn" {
  value = aws_alb_target_group.tg.arn
}


# output "tg_name_green" {
#   value = aws_alb_target_group.tg_green.name
# }
