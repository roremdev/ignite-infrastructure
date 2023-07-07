resource "aws_ecs_task_definition" "server" {
  family                   = local.environment
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 256 # .25 vCPU
  memory                   = 512 # .5 GB
  execution_role_arn       = data.aws_iam_role.server.arn

  container_definitions = jsonencode([
    {
      name      = local.environment
      image     = "${data.aws_ecr_repository.server.repository_url}:${local.environment}"
      cpu       = 256 # .25 vCPU
      memory    = 512 # .5 GB
      essential = true
      logConfiguration : {
        "logDriver" : "awslogs",
        "options" : {
          "awslogs-group" : local.monitor.server.log.group.name,
          "awslogs-region" : "us-east-1",
          "awslogs-stream-prefix" : local.monitor.server.log.stream.name,
        }
      },
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
      environment = [
        for key, secret in tomap(var.secrets.server) : {
          name  = upper(key)
          value = secret
        }
      ]
    }
  ])
}