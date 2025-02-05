output "cw_iam_role_name" {
  value = aws_iam_role.test_role.name
}

output "cw_iam_role_arn" {
  value = aws_iam_role.test_role.arn
}