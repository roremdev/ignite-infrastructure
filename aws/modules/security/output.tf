output "security" {
  description = "Security output by environment"
  value       = {
    iam_role = {
      server = {
        description = "Role to have execution tasks for AWS ECR and ECS"
        arn         = aws_iam_role.server.arn
        name        = aws_iam_role.server.name
      }
    }
  }
}