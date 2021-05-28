data "aws_caller_identity" "current" {}

variable "zone_id" {
  description = "zone id do dominio devopsteam.dev"
  default     = "Z04368091W6QIMLWGUKQA"
}

variable "app_name" {
  description = "entrada dns a ser criada"
  default     = "myapp"
}

variable "cluster_name" {
  description = "ECS Cluster Name"
  default     = "lab"
}

# Customize your AWS Region
variable "aws_region" {
  description = "AWS Region for the VPC"
  default     = "us-east-1"
}
# Customize your AWS local profile
variable "aws_profile" {
  description = "AWS profile"
  default     = "jonas-aws"
}

variable "tags" {
  type = map(any)
  default = {
    tribo   = "tag-tribo"
    squad   = "tag-squad"
    produto = "tag-produto"

  }
}
