resource "aws_lb" "server" {
  name               = local.network.load_balancer.server.name
  load_balancer_type = "application"
  subnets            = [aws_subnet.zone_a.id, aws_subnet.zone_b.id]
  security_groups    = [aws_security_group.load_balancer.id]

  tags = {
    environment = local.environment
  }
}