#Data block
data "aws_vpc" "default_vpc" {
  default = true
}

resource "aws_vpc_peering_connection" "vpc_peering" {
  vpc_id        = data.aws_vpc.default_vpc.id              # ID of the VPC from which the peering is initiated
  peer_vpc_id   = var.vpc_id        # The actual ID of the peer VPC
  peer_region   = var.region_name          # If the peer VPC is in a different region
  tags = {
    Name = var.vpc_peering_name
  }
}

resource "aws_vpc_peering_connection_accepter" "accepter" {
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering.id
  auto_accept               = true
}

data "aws_route_table" "default_RT" {
  vpc_id = data.aws_vpc.default_vpc.id
  filter {
    name = "association.main"
    values = [ "true" ]

  }
}

resource "aws_route" "default_rt" {
route_table_id = data.aws_route_table.default_RT.id
destination_cidr_block = var.cidr_range
vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering.id
  
}

resource "aws_route" "RT-1" {
  route_table_id = var.public_route_table_id
  destination_cidr_block = var.default_vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering.id

}
resource "aws_route" "RT-2" {
  route_table_id = var.private_route_table_id
  destination_cidr_block = var.default_vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering.id

}

data "aws_security_group" "default_sg" {
  vpc_id = data.aws_vpc.default_vpc.id
  filter {
    name = "group-name"
    values = [ "default" ]
  }
}
ubuntu@ip-172-31-0-9:/var/lib/jenkins/workspace/Jenkins_deployment/Jenkins-infra/modules/vpc_peering$ cd ..
ubuntu@ip-172-31-0-9:/var/lib/jenkins/workspace/Jenkins_deployment/Jenkins-infra/modules$ cd vpc
ubuntu@ip-172-31-0-9:/var/lib/jenkins/workspace/Jenkins_deployment/Jenkins-infra/modules/vpc$ cd ..
ubuntu@ip-172-31-0-9:/var/lib/jenkins/workspace/Jenkins_deployment/Jenkins-infra/modules$ cd vpc_peering/
ubuntu@ip-172-31-0-9:/var/lib/jenkins/workspace/Jenkins_deployment/Jenkins-infra/modules/vpc_peering$ ls
main.tf  output.tf  varibles.tf
ubuntu@ip-172-31-0-9:/var/lib/jenkins/workspace/Jenkins_deployment/Jenkins-infra/modules/vpc_peering$ cat output.tf 
output "vpc_peering_id" {
     value = aws_vpc_peering_connection.vpc_peering.id
  
}
output "vpc_id-01" {
  value = data.aws_vpc.default_vpc.id
}
ubuntu@ip-172-31-0-9:/var/lib/jenkins/workspace/Jenkins_deployment/Jenkins-infra/modules/vpc_peering$ cat varibles.tf 

variable "vpc_id" {
  type = string
}
variable "region_name" {
  type = string
  default = "us-east-1"
  
}

variable "vpc_peering_name" {
  type = string
  default = "tom_peering"
}


variable "cidr_range" {
  type = string
  default = "172.16.0.0/22"
}

variable"public_route_table_id" {
  type = string
}

variable "private_route_table_id" {
 type = string
}

variable "default_vpc_cidr" {
  type = string
  default = "172.31.0.0/16"

}
ubuntu@ip-172-31-0-9:/var/lib/jenkins/workspace/Jenkins_deployment/Jenkins-infra/modules/vpc_peering$ sudo vi varibles.tf 
ubuntu@ip-172-31-0-9:/var/lib/jenkins/workspace/Jenkins_deployment/Jenkins-infra/modules/vpc_peering$ cat varibles.tf 

variable "vpc_id" {
  type = string
}
variable "region_name" {
  type = string
  default = "us-east-1"
  
}

variable "vpc_peering_name" {
  type = string
  default = "jenkins_peering"
}


variable "cidr_range" {
  type = string
  default = "172.16.0.0/22"
}

variable"public_route_table_id" {
  type = string
}

variable "private_route_table_id" {
 type = string
}

variable "default_vpc_cidr" {
  type = string
  default = "172.31.0.0/16"

}
