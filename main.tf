provider "aws" {
  region = "us-west-2"
}
/* terraform {
  backend "s3" {
    bucket = "tool-setup-bucket-terraform-state"
    key = "jenkins-State-File/terraform.tfstate"
    region = "us-west-2"
  }
} */
module "network_module" {
  source = "./modules/network"

  /*--------------- VPC ---------------*/

  vpc_cidr                 = var.jenkins_vpc_cidr
  vpc_name                 = var.jenkins_vpc_name
  vpc_enable_dns_hostnames = var.jenkins_vpc_enable_dns_hostnames
  vpc_enable_dns_support   = var.jenkins_vpc_enable_dns_support

  /*--------------- Public Subnets ---------------*/

  public_subnets_cidr = var.jenkins_public_subnets_cidr
  public_subnets_az   = var.jenkins_public_subnets_az
  public_subnets_tags = var.jenkins_public_subnets_tags

  /*--------------- Private Subnets ---------------*/

  private_subnets_cidr = var.jenkins_private_subnets_cidr
  private_subnets_az   = var.jenkins_private_subnets_az
  private_subnets_tags = var.jenkins_private_subnets_tags

  /*--------------- # Internet Gateway ---------------*/
  igw_name = var.jenkins_igw_name

  /*--------------- NAT Gateway ---------------*/

  nat_name = var.jenkins_nat_name

  /*--------------- VPC peering ---------------*/
  
  existing_vpc_id = var.ninja_vpc_id
  existing_rtb = var.ninja_rtb
  existing_vpc_cidr = var.ninja_vpc_cidr

  /*--------------- Public RTB ---------------*/

  pub_route_table_name = var.jenkins_pub_route_table_name

  /*--------------- Private RTB ---------------*/

  pri_route_table_name = var.jenkins_pri_route_table_name

}

# module "efs_module" {
#   source = "./modules/efs"
#   vpc_id     = "vpc-060a50f71d3e22b4e"
#   subnet_ids = ["subnet-0a8741dccc388f1f6", "subnet-046aa42021a58f060", "subnet-0ed70b5997e539ec0"]
# }

# module "lb-asg" {
#   source        = "./modules/lb-asg"
#   subnets       = ["subnet-058a7514ba8adbb07", "subnet-0dbcd1ac168414927", "subnet-032f5077729435858"]
#   ami_id        = "ami-074d40b56472c5b9b"
#   instance_type = "t2.micro"
#   key_name      = "techiescamp"
#   environment   = "dev"
#   vpc_id        = "vpc-0a5ca4a92c2e10163"
# }

/* module "ec2_module" {
  source                     = "./modules/ec2"

  /*--------------- Bastion SG ---------------*/

 /* bastion_sg_name = var.jenkins_bastion_sg_name
  vpc_id          = module.network_module.vpc-id
  ingress_ports   = var.jenkins_ingress_ports

  /*--------------- Private SG ---------------*/

 /* private_sg_name = var.jenkins_private_sg_name
  public_subnets_cidr = [ var.jenkins_public_subnets_cidr[0] ]

  /*--------------- Key Pair ---------------*/

 /* key_pair = var.jenkins_key_pair

  /*--------------- Bastion Instance ---------------*/

  /* bastion_instance_name = var.jenkins_bastion_instance_name
  bastion_instance_type = var.jenkins_bastion_instance_type
  public_subnet_id = module.network_module.public-subnets-id[*]
  ami_id = data.aws_ami.ubuntu.id

  /*--------------- Private Instance ---------------*/

 /* private_subnet_id = module.network_module.private-subnets-id[*]
  private_instance_name = var.jenkins_private_instance_name
  private_instance_type = var.jenkins_private_instance_type
  efs_mount_point = module.efs_module.efs_dns_name

}

/* module "efs_module" {
  source = "./modules/efs"
  private_subnet_id = module.network_module.private-subnets-id[*]
  vpc_id          = module.network_module.vpc-id
} 
