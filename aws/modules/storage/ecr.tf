resource "aws_ecr_repository" "server" {
  name         = local.storage.repository.server.name
  force_delete = true
}