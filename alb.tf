resource "aws_alb" "app" {
  name            = local.alb_name
  subnets         = aws_subnet.public.*.id
  security_groups = [aws_security_group.alb.id]
}

resource "aws_alb_target_group" "ecs_task" {
  name        = local.tg_name
  port        = var.container_definitions[0].portMappings[0].hostPort
  protocol    = "HTTP"
  vpc_id      = aws_vpc.app.id
  target_type = "ip"

  health_check {
    healthy_threshold   = "3"
    interval            = "30"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = var.app_health_check_path
    unhealthy_threshold = "2"
  }
}

resource "aws_alb_listener" "frontend_http" {
  load_balancer_arn = aws_alb.app.id
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.ecs_task.id
    type             = "forward"
  }
}

resource "aws_alb_listener" "frontend_https" {
  load_balancer_arn = aws_alb.app.id
  port              = 443
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.ecs_task.id
    type             = "forward"
  }
}
