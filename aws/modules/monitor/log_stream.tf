resource "aws_cloudwatch_log_stream" "server" {
  name           = local.monitor.server.log.stream.name
  log_group_name = aws_cloudwatch_log_group.server.name
}