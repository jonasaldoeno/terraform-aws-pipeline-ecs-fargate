resource "aws_codebuild_project" "app_build" {
  name          = format("%s-%s-codebuild", var.cluster_name, var.app_service_name)
  build_timeout = "60"

  service_role = aws_iam_role.codebuild_role.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type = "BUILD_GENERAL1_SMALL"

    // https://docs.aws.amazon.com/codebuild/latest/userguide/build-env-ref-available.html
    image           = var.build_image
    type            = "LINUX_CONTAINER"
    privileged_mode = true

    environment_variable {
      name  = "repository_url"
      value = var.repository_url
    }

    environment_variable {
      name  = "region"
      value = var.region
    }

    environment_variable {
      name  = "container_name"
      value = var.container_name
    }

  }

  source {
    type      = "CODEPIPELINE"
  }

  # source {
  #   type      = "CODEPIPELINE"
  #   buildspec =<<DEFINITION
  #   version: 0.2

  #   phases:
  #     install:
  #       runtime-versions:
  #         python: 3.7
  #     pre_build:  
  #       commands:  
  #         - echo Logging in to Amazon ECR...
  #         - CONTAINER_NAME=${var.container_name}
  #         - echo Entered the pre_build phase...
  #     build:
  #       commands:
  #         - REPOSITORY_URI=$(cat imageDetail.json | python -c "import sys, json; print(json.load(sys.stdin)['ImageURI'].split('@')[0])")
  #         - IMAGE_TAG=$(cat imageDetail.json | python -c "import sys, json; json=json.load(sys.stdin); print (json['ImageTags'][0]) if (json['ImageTags'][0] != 'latest') else print (json['ImageTags'][1])")
  #         - echo $REPOSITORY_URI:$IMAGE_TAG
  #     post_build:
  #       commands:
  #         - echo Writing image definitions file...
  #         - printf '[{"name":"%s","imageUri":"%s"}]' $CONTAINER_NAME $REPOSITORY_URI:$IMAGE_TAG > imagedefinitions.json
  #   artifacts:
  #       files: imagedefinitions.json
  #   DEFINITION
  # }
  tags = var.tags
  depends_on = [aws_s3_bucket.source]
}