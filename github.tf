data "github_repository" "app" {
  full_name = var.gh_repo
}

resource "github_repository_environment" "env" {
  environment         = var.gh_repo_environment
  repository          = data.github_repository.app.name
  prevent_self_review = true
  can_admins_bypass   = false
}

resource "github_actions_secret" "aws_access_key_id" {
  repository      = data.github_repository.app.name
  secret_name     = "AWS_ACCESS_KEY_ID"
  plaintext_value = var.aws_access_key_id
}

resource "github_actions_secret" "aws_secret_access_key" {
  repository      = data.github_repository.app.name
  secret_name     = "AWS_SECRET_ACCESS_KEY"
  plaintext_value = var.aws_secret_access_key
}

resource "github_actions_variable" "iam_role_build" {
  repository    = data.github_repository.app.name
  variable_name = "AWS_ROLE_BUILD"
  value         = var.assume_role_arn
}

resource "github_actions_environment_variable" "iam_role_deploy" {
  environment   = github_repository_environment.env.environment
  repository    = data.github_repository.app.name
  variable_name = "AWS_ROLE_DEPLOY"
  value         = var.assume_role_arn
}

resource "github_actions_environment_variable" "ecs_fargate_cluster" {
  environment   = github_repository_environment.env.environment
  repository    = data.github_repository.app.name
  variable_name = "ECS_CLUSTER"
  value         = aws_ecs_cluster.app.name
}

resource "github_actions_environment_variable" "ecs_service" {
  environment   = github_repository_environment.env.environment
  repository    = data.github_repository.app.name
  variable_name = "ECS_SERVICE"
  value         = aws_ecs_service.app.name
}

resource "github_actions_environment_variable" "ecs_task_definition" {
  environment   = github_repository_environment.env.environment
  repository    = data.github_repository.app.name
  variable_name = "ECS_TASK_DEFINITION"
  value         = aws_ecs_task_definition.app.family
}

resource "github_actions_variable" "ecr_repository_url" {
  repository    = data.github_repository.app.name
  variable_name = "ECR_REPOSITORY_URL"
  value         = aws_ecr_repository.app.repository_url
}

resource "github_actions_variable" "aws_region" {
  repository    = data.github_repository.app.name
  variable_name = "AWS_REGION"
  value         = var.region
}
