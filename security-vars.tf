/*---------------SG variables---------------*/

variable "jenkins_ingress_ports" {
  type        = list(number)
  description = "SG inbound ports"
#   default     = [22, 443, 80]
}
variable "jenkins_bastion_sg_name" {
  type    = string
#   default = "bastion-SG"
}

variable "jenkins_private_sg_name" {
  type    = string
#   default = "private-SG"
}

/*--------------- Key pair variables ---------------*/

variable "jenkins_key_pair" {
  type    = string
#   default = "ninja-01"
}

/*--------------- AMI variables---------------*/

# variable "jenkins_ami_id" {
#   type    = string
#   default = "ami-00983e8a26e4c9bd9"
# }

/*--------------- Bastion Instance ---------------*/

variable "jenkins_bastion_instance_type" {
  type        = string
#   default     = "t2.micro"
  description = "type of instance for bastion server"
}

variable "jenkins_bastion_instance_name" {
  type        = string
#   default     = "bastion-instance"
  description = "bastion instance name"
}

/*--------------- Private Instance ---------------*/

variable "jenkins_private_instance_type" {
  type        = string
#   default     = "t2.micro"
  description = "type of instance for bastion server"
}

variable "jenkins_private_instance_name" {
  type        = string
#   default     = "private-instance"
  description = "bastion instance name"
}
