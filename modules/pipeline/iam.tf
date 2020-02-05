resource "aws_iam_role" "codepipeline_role" {
  name               = format("codepipeline-%s-%s-role", var.cluster_name, var.app_service_name)
  assume_role_policy = file(format("%s/templates/policies/codepipeline_role.json", path.module))
  tags = var.tags
}

data "template_file" "codepipeline_policy" {
  template = file(format("%s/templates/policies/codepipeline.json", path.module))

  vars = {
    aws_s3_bucket_arn = aws_s3_bucket.source.arn
  }
}

resource "aws_iam_role_policy" "codepipeline_policy" {
  name   = format("codepipeline-%s-%s-policy", var.cluster_name, var.app_service_name)
  role   = aws_iam_role.codepipeline_role.id
  policy = data.template_file.codepipeline_policy.rendered
}

resource "aws_iam_role" "codebuild_role" {
  name               = format("codebuild-%s-%s-role", var.cluster_name, var.app_service_name)
  assume_role_policy = file(format("%s/templates/policies/codebuild_role.json", path.module))
  tags = var.tags
}

data "template_file" "codebuild_policy" {
  template = file(format("%s/templates/policies/codebuild_policy.json", path.module))

  vars = {
    aws_s3_bucket_arn = aws_s3_bucket.source.arn
  }
}

resource "aws_iam_role_policy" "codebuild_policy" {
  name    = format("codebuild-%s-%s-policy", var.cluster_name, var.app_service_name)
  role    = aws_iam_role.codebuild_role.id
  policy  = data.template_file.codebuild_policy.rendered
}

resource "aws_iam_role" "codedeploy_role" {
  name               = format("codedeploy-%s-%s-role", var.cluster_name, var.app_service_name)
  assume_role_policy = file(format("%s/templates/policies/codedeploy_role.json", path.module))
  tags = var.tags
}

data "template_file" "codedeploy_policy" {
  template = file(format("%s/templates/policies/codedeploy_policy.json", path.module))
  
}

resource "aws_iam_role_policy" "codedeploy_policy" {
  name    = format("codedeploy-%s-%s-policy", var.cluster_name, var.app_service_name)
  role    = aws_iam_role.codedeploy_role.id
  policy  = data.template_file.codedeploy_policy.rendered
}

resource "aws_iam_role" "events_role" {
  name               = format("events-%s-%s-role", var.cluster_name, var.app_service_name)
  assume_role_policy = file(format("%s/templates/policies/events_role.json", path.module))
  tags = var.tags
}

data "template_file" "events_policy" {
  template = file(format("%s/templates/policies/events_policy.json", path.module))

  vars = {
    aws_codepipeline_pipeline_arn = aws_codepipeline.pipeline.arn
  }
}

resource "aws_iam_role_policy" "events_policy" {
  name    = format("events-%s-%s-policy", var.cluster_name, var.app_service_name)
  role    = aws_iam_role.events_role.id
  policy  = data.template_file.events_policy.rendered
}
