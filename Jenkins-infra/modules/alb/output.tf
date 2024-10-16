output "load_balancer_id" {
  value = aws_lb.jenkins_lb.id  
}

output "listener_arn" {
  value = aws_lb_listener.alb.arn 
}

output "target_group_arn" {
  value = aws_lb_target_group.jenkins_tg.arn
}
