output "alb_arn" {
  value = aws_lb.test.arn
}
output "internal_listner" {
  value = aws_lb_listener.listner.arn
}
