# terraform {
#   required_version = "~> 0.12"

#   backend "s3" {
#     encrypt = true
#   }
# }

# Customize the Cluster Name
variable "cluster_name" {
  description = "ECS Cluster Name"
  default = "lab"
}

# Customize your AWS Region
variable "aws_region" {
  description = "AWS Region for the VPC"
  default     = "sa-east-1"
}

# # VPC
# variable "vpc_id" {
#   description = "The ID of the VPC"
# }

# # Subnets
# variable "private_subnets" {
#   description = "List of IDs of private subnets"
# }

# variable "public_subnets" {
#   description = "List of IDs of public subnets"
# }

# variable "certificate" {}

variable "tags" {
  type = map
  default = {
    CCusto  = "Teste"
    Produto = "Teste"
  }
}

# Provider
provider "aws" {
  region = var.aws_region
}

data "aws_caller_identity" "current" {}
