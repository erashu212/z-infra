data "template_file" "this" {
  template = file("${path.module}/data/container_definition.json")
  vars     = merge(var.container_definition, { name = "${var.module_name}-${var.environment}-container" })
}

resource "aws_ecs_task_definition" "this" {
  family = "${var.module_name}-task"

  container_definitions    = data.template_file.this.rendered
  requires_compatibilities = [
    "FARGATE"
  ]
  network_mode       = "awsvpc"
  memory             = lookup(var.container_definition, "memory", "512" )
  cpu                = lookup(var.container_definition, "cpu", "256")
  execution_role_arn = var.ecs_iam_role_arn
  task_role_arn      = var.ecs_iam_role_arn

  tags = {
    Name        = "${var.module_name}-ecs-td"
    Environment = var.environment
  }
}