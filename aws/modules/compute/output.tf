output "compute" {
  description = "Compute output by environment"
  value       = {
    server = {
      cluster = {
        id   = aws_ecs_cluster.server.id
        name = aws_ecs_cluster.server.name
      }
      task = {
        id     = aws_ecs_task_definition.server.id
        family = aws_ecs_task_definition.server.family
      }
    }
  }
}