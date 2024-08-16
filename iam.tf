data "aws_caller_identity" "current" {}

resource "aws_iam_role" "app" {
  name = local.iam_role_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        },
        Action = ["sts:AssumeRole", "sts:TagSession"]
        # Condition = {
        #   StringEquals = {
        #     "aws:ResourceTag/App" = [
        #       var.app_name
        #     ]
        #   }
        # }
      }
    ]
  })
}

resource "aws_iam_policy" "app_policy" {
  name        = local.app_policy_name
  description = "Policy to allow the ECS task (${local.task_name}) to connect with the AWS Services"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability",
        ],
        Resource = [
          aws_ecr_repository.app.arn
        ]
      },
      {
        Effect : "Allow",
        Action : "ecr:GetAuthorizationToken",
        Resource : "*"
      },
      {
        Effect = "Allow",
        Action = [
          "logs:*"
        ],
        Resource = ["*", ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "app_ecr_pull_policy" {
  role       = aws_iam_role.app.name
  policy_arn = aws_iam_policy.app_policy.arn
}
