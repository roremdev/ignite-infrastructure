resource "aws_alb_target_group" "server" {
  name        = local.network.load_balancer.server.target_group.name
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_vpc.global.id

  health_check {
    matcher = "200,301,302"
    path    = "/"
  }

  tags = {
    environment = local.environment
  }

  lifecycle {
    create_before_destroy = true
  }
}