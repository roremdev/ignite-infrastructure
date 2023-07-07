resource "aws_lb_listener" "server" {
  load_balancer_arn = aws_lb.server.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.server.arn
  }

  tags = {
    Name        = local.network.load_balancer.server.listener.name
    environment = local.environment
  }
}