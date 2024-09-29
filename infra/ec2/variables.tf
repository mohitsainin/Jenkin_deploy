/*---------------SG variables---------------*/

variable "ingress_ports" {
  type        = list(number)
  description = "SG inbound ports"
#   default     = [22, 443, 80]
}
variable "bastion_sg_name" {
  type    = string
#   default = "bastion-SG"
}

variable "private_sg_name" {
  type    = string
#   default = "private-SG"
}
variable "public_subnets_cidr" {
  type = list(string)
}
variable "vpc_id" {
    type    = string
}
/*--------------- Key pair variables ---------------*/

variable "key_pair" {
  type    = string
#   default = "ninja-01"
}

/*--------------- AMI variables---------------*/

variable "ami_id" {
  type    = string
#   default = "ami-00983e8a26e4c9bd9"
}

/*--------------- Bastion Instance ---------------*/

variable "bastion_instance_type" {
  type        = string
#   default     = "t2.micro"
  description = "instance type for bastion server"
}

variable "bastion_instance_name" {
  type        = string
#   default     = "bastion-instance"
  description = "bastion instance name"
}

variable "public_subnet_id" {
    type    = list(string)
}

/*--------------- Private Instance ---------------*/

variable "private_instance_type" {
  type        = string
#   default     = "t2.medium"
  description = "instance type for jenkins server"
}

variable "private_instance_name" {
  type        = string
#   default     = "private-instance"
  description = "jenkins instance name"
}

variable "private_subnet_id" {
    type    = list(string)
}
variable "efs_mount_point" {
    type    = string
}
