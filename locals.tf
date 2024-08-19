locals {
  execution_role         = "${replace(title(var.app_name), "-", "")}ExecutionRole"
  execution_policy       = "${replace(title(var.app_name), "-", "")}ExecutionPolicy"
  task_role              = "${replace(title(var.app_name), "-", "")}TaskRole"
  task_policy            = "${replace(title(var.app_name), "-", "")}TaskPolicy"
  ecr_name               = "ecr-${var.app_name}"
  cluster_name           = "fargate-${var.app_name}"
  service_name           = "service-${var.app_name}"
  task_name              = "task-${var.app_name}"
  alb_name               = "alb-${var.app_name}"
  tg_name                = "tg-${var.app_name}"
}
