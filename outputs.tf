output "alb_dns_name" {
  description = "The DNS name of the ALB"
  value       = aws_alb.app.dns_name
}

output "gh_repo_url" {
  description = "The URL of the GitHub repository"
  value       = data.github_repository.app.html_url
}

output "ecr_registry_url" {
  description = "The registry ID of the ECR repository"
  value       = aws_ecr_repository.app.repository_url
}