output "load_balancer_id" {
  value = aws_lb.jenkins_lb.id  # Ensure this points to the correct resource
}

output "listener_arn" {
  value = aws_lb_listener.alb.arn  # Ensure this points to the correct resource
}

output "target_group_arn" {
  value = aws_lb_target_group.jenkins_tg.arn
}
