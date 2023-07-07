resource "aws_ecs_service" "server" {
  name                 = local.environment
  cluster              = aws_ecs_cluster.server.name
  task_definition      = aws_ecs_task_definition.server.arn
  launch_type          = "FARGATE"
  desired_count        = 2
  force_new_deployment = true

  network_configuration {
    assign_public_ip = true
    subnets          = data.aws_subnets.public.ids
    security_groups  = [data.aws_security_group.server.id]
  }

  load_balancer {
    target_group_arn = data.aws_lb_target_group.server.arn
    container_name   = aws_ecs_task_definition.server.family
    container_port   = 80
  }
}