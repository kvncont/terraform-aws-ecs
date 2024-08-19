data "local_file" "container_definitions" {
  filename = "${path.module}/templates/container-definitions.json"
}

locals {
  app_name = "ms-family-budget"
  gh_repo  = "kvncont/${local.app_name}"
}

module "app" {
  source                = "../../"
  aws_access_key_id     = var.aws_access_key_id
  aws_secret_access_key = var.aws_secret_access_key
  region                = var.region
  assume_role_arn       = var.assume_role_arn
  vpc_cidr_block        = "10.0.0.0/16"
  app_name              = local.app_name
  app_port              = 80
  gh_repo               = local.gh_repo
  gh_repo_environment   = "production"
  container_definitions = [
    {
      name  = local.app_name
      image = "nginx:latest" # Should be the ECR image URL
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
      cpu    = 256
      memory = 512
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = "ecs/${local.app_name}"
          "awslogs-region"        = var.region
          "awslogs-stream-prefix" = "app"
        }
      }
    },
    {
      name   = "sidecar"
      image  = "nginx:latest"
      cpu    = 256
      memory = 512
      portMappings = [
        {
          containerPort = 80
          hostPort      = 8080
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = "ecs/${local.app_name}"
          "awslogs-region"        = var.region
          "awslogs-stream-prefix" = "sidecar"
        }
      }
    }
  ]
}
