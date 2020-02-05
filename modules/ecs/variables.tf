variable "cluster_name" {}

variable "cluster_domain" {
  default = ""
}

variable "capacity_providers" {
  type = list
  default = ["FARGATE"]
}

variable "enable_container_insights" {
  type    = bool
  default = false
}

variable "vpc_id" {}

variable "target_group_arn" {}


variable "private_subnets" {
  type = list(string)
}

variable "public_subnets" {
  type = list(string)
}

variable "listener" {
  type        = map
  default = {
    port            = "80"
    certificate_arn = ""
    ssl_policy      = "ELBSecurityPolicy-TLS-1-1-2017-01"
  }
}
variable "tags" {
  
}

