# Cluster Execution Role
resource "aws_iam_role" "ecs_execution_role" {
  name               = format("ecs-task-%s-%s-role", var.cluster_name, var.service_name)
  assume_role_policy = file(format("%s/policies/ecs-task-execution-role.json", path.module))
  tags = var.tags
}

# Cluster Execution Policy
resource "aws_iam_role_policy" "ecs_execution_role_policy" {
  name   = format("ecs-task-%s-%s-policy", var.cluster_name, var.service_name)
  policy = file(format("%s/policies/ecs-execution-role-policy.json", path.module))
  role   = aws_iam_role.ecs_execution_role.id
}
