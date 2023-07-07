output "storage" {
  description = "Storage output by environment"
  value       = {
    repository = {
      server = {
        name = aws_ecr_repository.server.name
        url  = aws_ecr_repository.server.repository_url
      }
    }
  }
}