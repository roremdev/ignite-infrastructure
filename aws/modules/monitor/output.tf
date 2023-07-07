output "monitor" {
  description = "CloudWatch metadata"
  value       = {
    log = {
      group = {
        id   = aws_cloudwatch_log_group.server.id
        name = aws_cloudwatch_log_group.server.name
      }
      stream = {
        id   = aws_cloudwatch_log_stream.server.id
        name = aws_cloudwatch_log_stream.server.name
      }
    }
  }
}