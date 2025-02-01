locals {
  name = "${var.environment}-${var.project_name}-${var.cw_name}"
}
resource "aws_iam_role" "test_role" {
  name = local.name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
  tags = merge(
    {
      Name = local.name
    },
    var.common_tags
  )
}
resource "aws_iam_policy" "test_policy" {
  name        = local.name
  description = "Allow CloudWatch and Logs access"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogStreams"
        ]
        Resource = "arn:aws:logs:us-east-1:522814728660:*"
      },
      {
        Effect = "Allow"
        Action = [
          "cloudwatch:PutMetricData"
        ]
        Resource = "*"
      }
    ]
  })
  
  tags = merge(
    {
      Name = local.name
    },
    var.common_tags
  )
}

resource "aws_iam_role_policy_attachment" "test_attachment" {
  role       = aws_iam_role.test_role.name
  policy_arn = aws_iam_policy.test_policy.arn
}
