/*--------------- EFS SG ---------------*/

resource "aws_security_group" "efs_sg" {
  name_prefix = "efs-sg"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

/*--------------- EFS ---------------*/

resource "aws_efs_file_system" "jenkins" {
  creation_token = "jenkins"
  encrypted      = true
  performance_mode = "generalPurpose"
  throughput_mode  = "bursting"
  tags = {
    Name = "jenkins-efs"
  }
}

resource "aws_efs_mount_target" "jenkins" {
  count = length(var.private_subnet_id)
  file_system_id   = aws_efs_file_system.jenkins.id
  subnet_id        = var.private_subnet_id[count.index]
  security_groups = [aws_security_group.efs_sg.id]
}

output "efs_dns_name" {
  value = aws_efs_file_system.jenkins.dns_name
}
