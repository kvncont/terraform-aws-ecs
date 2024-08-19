resource "aws_security_group" "alb" {
  name        = "alb-${var.app_name}"
  description = "Controls access to the ALB"
  vpc_id      = aws_vpc.app.id

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg-alb-${var.app_name}"
  }
}

resource "aws_security_group" "ecs" {
  name        = "ecs-${var.app_name}"
  description = "Controls access to the ECS instances"
  vpc_id      = aws_vpc.app.id

  ingress {
    protocol        = "tcp"
    from_port       = var.container_definitions[0].portMappings[0].hostPort
    to_port         = var.container_definitions[0].portMappings[0].hostPort
    security_groups = [aws_security_group.alb.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg-ecs-${var.app_name}"
  }
}
