data "aws_vpc" "global" {
  filter {
    name   = "tag:Name"
    values = [local.network.vpc.name]
  }
}

data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.global.id]
  }

  tags = {
    scope = "public"
  }
}

data "aws_security_group" "server" {
  name = local.network.security_group.server.name
}

data "aws_lb_target_group" "server" {
  name = local.network.load_balancer.server.target_group.name
}

data "aws_iam_role" "server" {
  name = local.security.iam_role.server.name
}

data "aws_ecr_repository" "server" {
  name = local.storage.repository.server.name
}
