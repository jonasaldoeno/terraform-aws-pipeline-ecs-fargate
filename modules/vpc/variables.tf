variable "name" {}
variable "cidr" {}

variable "azs" {
  type = list(string)
}
variable "private_subnets" {
  type = list(string)
}
variable "public_subnets" {
  type = list(string)
}

variable "enable_nat_gateway" {}
variable "enable_vpn_gateway" {}
variable "single_nat_gateway" {}
variable "reuse_nat_ips" {}
variable "external_nat_ip_ids" {}