/**
 * ℹ️Overview
 * This resource creates several CloudWatch log streams for monitoring
 * the server outputs.
 *
 * Dynamically, all flows are created based on the stream names specification.
 *
 * 📝Attributes:
 * - name: Name of the stream, following the environment name.
 */
resource "aws_cloudwatch_log_stream" "server" {
  name           = local.monitor.server.log.stream.name
  log_group_name = aws_cloudwatch_log_group.server.name
}