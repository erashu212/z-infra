resource "aws_cloudwatch_log_group" "this" {
  name = "${var.module_name}-${var.environment}-logs"

  tags = {
    Application = var.module_name
    Environment = var.environment
  }
}