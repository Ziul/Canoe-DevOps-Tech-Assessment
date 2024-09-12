
output "task_cluster" {
  value = aws_ecs_cluster.ecs_cluster.id
  description = "ECS Task Cluster ID"
}

output "task" {
  value = aws_ecs_task_definition.task.id
  description = "ECS Task ID"
}


output "ecs_service" {
  value = aws_ecs_service.ecs_service.id
  description = "ECS Service ID"
}