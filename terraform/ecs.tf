resource "aws_ecs_cluster" "app" {
  name = "fargate-${var.app_name}"
}

data "template_file" "app" {
  template = file("../templates/ecs-app.json.tpl")

  vars = {
    app_name       = var.app_name
    app_image      = var.app_image
    app_port       = var.app_port
    fargate_cpu    = var.fargate_cpu
    fargate_memory = var.fargate_memory
    aws_region     = var.region
  }
}

resource "aws_ecs_task_definition" "app" {
  family                   = "task-${var.app_name}"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory
  container_definitions    = data.template_file.app.rendered
}

resource "aws_ecs_service" "app" {
  name            = "service-${var.app_name}"
  cluster         = aws_ecs_cluster.app.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = var.app_count
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = aws_subnet.public[*].id
    assign_public_ip = true
    security_groups  = [aws_security_group.ecs.id]
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.ecs_task.arn
    container_name   = var.app_name
    container_port   = var.app_port
  }
}
