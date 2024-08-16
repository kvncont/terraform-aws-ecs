locals {
  app_name = "ms-family-budget"
  gh_repo  = "kvncont/${local.app_name}"
}

module "app" {
  source                = "../"
  region                = "us-east-1"
  assume_role_arn       = var.assume_role_arn
  vpc_cidr_block        = "10.0.0.0/16"
  app_name              = local.app_name
  app_port              = 80
  aws_access_key_id     = var.aws_access_key_id
  aws_secret_access_key = var.aws_secret_access_key
  gh_repo               = local.gh_repo
  gh_repo_environment   = "production"
}
