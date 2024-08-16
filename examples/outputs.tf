output "gh_repo_url" {
  description = "The URL of the GitHub repository"
  value       = module.app.gh_repo_url
}

output "ecr_registry_url" {
  description = "The URL of the ECR registry"
  value       = module.app.ecr_registry_url
}

output "app_url" {
  description = "The URL of the application"
  value       = module.app.alb_dns_name
}