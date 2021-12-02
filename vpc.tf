# VPC definition
#
# us-east-1a, us-east-1b, us-east-1c
#
# Public VPC:
#   - us-east-1a - 10.0.5.0/24
#   - us-east-1b - 10.0.6.0/24
#   - us-east-1c - 10.0.7.0/24


provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 2.62"

  name = var.vpc_name
  cidr = var.vpc_cidr

  azs            = [for az in keys(var.vpc_public_subnets) : az]
  public_subnets = [for cidr in values(var.vpc_public_subnets) : cidr]

  enable_nat_gateway   = true
  enable_dns_hostnames = true

  tags = local.common_tags
}