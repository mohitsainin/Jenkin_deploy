output "efs_dns_name" {
  value = module.efs_module.efs_dns_name
}

output "jenkins_alb_dns_name" {
  value = module.ec2_module.alb_dns_name
}
