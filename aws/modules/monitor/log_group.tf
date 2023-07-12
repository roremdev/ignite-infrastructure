/**
 * ℹ️Description
 * This resource is responsible for creating a CloudWatch log group to group
 * all the log streams to monitor the server outputs.
 *
 * 📝Attributes:
 * - name: Name of the group, following the name convention: <project>-<service>.
 *         For example: dashboard-server.
 * - retention_in_days: Number of days to keep the logs.
 */
resource "aws_cloudwatch_log_group" "server" {
  name              = local.monitor.server.log.group.name
  retention_in_days = 14
}