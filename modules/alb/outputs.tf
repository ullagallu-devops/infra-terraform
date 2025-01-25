output "arn" {
  value = aws_lb.test.arn
}
output "http_listner" {
  value = aws_lb_listener.http[*].arn
}
output "https_listner" {
  value = aws_lb_listener.https[*].arn
}
