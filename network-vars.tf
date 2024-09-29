/*---------------vpc variables---------------*/
variable "jenkins_vpc_cidr" {
  type = string
  #   default = "10.0.0.0/16"
}

variable "jenkins_vpc_enable_dns_support" {
  type = bool
  #   default = true
}

variable "jenkins_vpc_enable_dns_hostnames" {
  type = bool
  #   default = true
}

variable "jenkins_vpc_name" {
  type = string
  #   default = "jenkins-vpc-01"
}
/*---------------subnet variables---------------*/

/*--------------- Public Subnets ---------------*/

variable "jenkins_public_subnets_cidr" {
  description = "public subnet cidr block"
  type        = list(string)
  #   default     = ["10.0.2.0/24", "10.0.4.0/24"]

}

variable "jenkins_public_subnets_az" {
  description = "public subnet availability zones"
  type        = list(string)
  #   default     = ["us-west-1b", "us-west-1c"]
}
variable "jenkins_enable_map_public_ip_on_launch" {
  type = bool
  #   default = true
}

variable "jenkins_public_subnets_tags" {
  description = "public subnet tags"
  type        = list(map(string))
  #   default = [{
  #     "Name" = "jenkins-pub-sub-01"
  #     }, {
  #     "Name" = "jenkins-pub-sub-02"
  #   }]
}

/*--------------- Private Subnets ---------------*/

variable "jenkins_private_subnets_cidr" {
  description = "private subnet cidr block"
  type        = list(string)
  #   default     = ["10.0.6.0/24", "10.0.8.0/24"]

}

variable "jenkins_private_subnets_az" {
  description = "private subnet availability zones"
  type        = list(string)
  #   default     = ["us-west-1b", "us-west-1c"]

}

variable "jenkins_private_subnets_tags" {
  description = "private subnet tags"
  type        = list(map(string))
  #   default = [{
  #     "Name" = "jenkins-priv-sub-01"
  #     }, {
  #     "Name" = "jenkins-priv-sub-02"
  #   }]
}

/*--------------- # Internet Gateway ---------------*/

variable "jenkins_igw_name" {
  type = string
  #   default = "jenkins-igw-01"
}

/*--------------- # NAT Gateway ---------------*/

variable "jenkins_nat_name" {
  type = string
  #   default = "jenkins-nat-01"
}

/*--------------- # VPC peering ---------------*/

variable "ninja_vpc_id" {
  type    = string
  default = "vpc-09e0f8a5b064ea2f4"
}

variable "ninja_vpc_cidr" {
  type    = string
  default = "20.0.0.0/16"
}

variable "ninja_rtb" {
  type    = string
  default = "rtb-0fbe6a2b3ec8e528c"
}

/*--------------- # Route Table ---------------*/

variable "jenkins_pub_route_table_name" {
  type = string
  #   default = "jenkins-route-pub-01"
}

variable "jenkins_pri_route_table_name" {
  type = string
  #   default = "jenkins-route-priv-01"
}
