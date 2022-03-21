output "cluster" {
  value = {
    id  = aws_ecs_cluster.this.id
    arn = aws_ecs_cluster.this.arn
  }
}

output "task_definition" {
  value = {
    id  = aws_ecs_task_definition.this.id
    arn = aws_ecs_task_definition.this.arn
  }
}

output "service" {
  value = {
    id = aws_ecs_service.this.id
  }
}