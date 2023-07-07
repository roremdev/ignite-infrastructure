resource "aws_vpc" "global" {
  cidr_block           = local.network.vpc.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = local.network.vpc.name
    environment = local.environment
  }
}