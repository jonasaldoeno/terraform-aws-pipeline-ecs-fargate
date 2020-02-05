resource "aws_cloudwatch_event_rule" "ecr_latest_image" {
    name     = format("%s-%s-rule", var.cluster_name, var.app_service_name)
    event_pattern = <<PATTERN
    {
        "source": [
            "aws.ecr"
        ],
        "detail": {
            "eventSource": [
                "ecr.amazonaws.com"
            ],
            "eventName": [
                "PutImage"
            ],
            "requestParameters": {
                "repositoryName": [
                    "${var.repository_name}"
                ],
                "imageTag": [
                    "latest"
                ]
            }
        }
    }
    PATTERN
    tags = var.tags
}

resource "aws_cloudwatch_event_target" "ecr_pipeline_target" {
  rule      = aws_cloudwatch_event_rule.ecr_latest_image.name
  arn       = aws_codepipeline.pipeline.arn
  role_arn  = aws_iam_role.events_role.arn
}