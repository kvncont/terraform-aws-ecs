data "aws_caller_identity" "current" {}

resource "aws_iam_role" "app_execution" {
  name = local.execution_role
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        },
        Action = ["sts:AssumeRole", "sts:TagSession"]
        "Condition" : {
          "StringEquals" : {
            "aws:ResourceTag/App" : var.app_name
          }
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "app_execution" {
  name = local.execution_policy
  role = aws_iam_role.app_execution.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ecr:BatchCheckLayerAvailability",
          "ecr:BatchGetImage",
          "ecr:GetDownloadUrlForLayer"
        ],
        Resource = [
          aws_ecr_repository.app.arn
        ]
      },
      {
        Effect   = "Allow",
        Action   = "ecr:GetAuthorizationToken"
        Resource = "*"
      },
      {
        Effect = "Allow",
        Action = [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = "${aws_cloudwatch_log_group.app.arn}:*"
      }
    ]
  })
}

resource "aws_iam_role" "app_task" {
  name = local.task_role
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        },
        Action = ["sts:AssumeRole", "sts:TagSession"]
        "Condition" : {
          "StringEquals" : {
            "aws:ResourceTag/App" : var.app_name
          }
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "app_task" {
  name = local.task_policy
  role = aws_iam_role.app_task.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Deny",
        Action   = ["*"],
        Resource = ["*"]
      }
    ]
  })
}
