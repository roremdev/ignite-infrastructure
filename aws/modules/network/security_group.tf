resource "aws_security_group" "load_balancer" {
  name        = local.network.security_group.load_balancer.name
  description = local.network.security_group.load_balancer.description
  vpc_id      = aws_vpc.global.id

    dynamic "ingress" {
      for_each = local.network.security_group.load_balancer.ingress
      content {
        description = ingress.value.description
        from_port   = ingress.value.from_port
        to_port     = ingress.value.to_port
        protocol    = ingress.value.protocol
        cidr_blocks = ingress.value.cidr_blocks
      }
    }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = local.network.security_group.load_balancer.name
    environment = local.environment
  }
}

resource "aws_security_group" "server" {
  name        = local.network.security_group.server.name
  description = local.network.security_group.server.description
  vpc_id      = aws_vpc.global.id

  ingress {
    description     = "Allow HTTP from security groups"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.load_balancer.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = local.network.security_group.server.name
    environment = local.environment
  }
}