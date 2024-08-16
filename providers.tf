terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region     = var.region
  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_access_key
  assume_role {
    role_arn = var.assume_role_arn
  }
  default_tags {
    tags = {
      App        = var.app_name
      ManagedBy  = "terraform"
      GitRepoURL = data.github_repository.app.html_url
    }
  }
}
