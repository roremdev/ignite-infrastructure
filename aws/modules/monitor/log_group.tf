resource "aws_cloudwatch_log_group" "server" {
  name              = local.monitor.server.log.group.name
  retention_in_days = 14
}