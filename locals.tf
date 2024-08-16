locals {
  iam_role_name          = "${replace(title(var.app_name), "-", "")}Role"
  app_policy_name        = "${replace(title(var.app_name), "-", "")}AppPolicy"
  ecs_deploy_policy_name = "${replace(title(var.app_name), "-", "")}ECSDeployPolicy"
  ecr_name               = "ecr-${var.app_name}"
  cluster_name           = "fargate-${var.app_name}"
  service_name           = "service-${var.app_name}"
  task_name              = "task-${var.app_name}"
  alb_name               = "alb-${var.app_name}"
  tg_name                = "tg-${var.app_name}"
}