output "load_balancer_id" {
  value = aws_lb.jenkins_lb.id
}

output "target_group_arn" {
  value = aws_lb_jenkins_group_tg.arn
}

output "listener_arn" {
  value = aws_lb_listener.alb.arn
}
