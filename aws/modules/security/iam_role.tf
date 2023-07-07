resource "aws_iam_role" "server" {
  name               = local.security.iam_role.server.name
  description        = local.security.iam_role.server.description
  assume_role_policy = data.aws_iam_policy_document.server.json
  tags               = {
    environment = local.environment
  }
}