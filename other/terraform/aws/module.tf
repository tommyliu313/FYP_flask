module "cloudwatch" {
  source  = "terraform-aws-modules/cloudwatch/aws"
  version = "2.5.0"
}

module "vpc"{
 source = "terraform-aws-modules/vpc/aws"
 version = "2.66.0"
 name = "my-vpc"
 cidr = var.cidr_block
 azs = [var.aws_region,var.aws_region2]
 private_subnet = var.private_subnet
 public_subnet = var.public_subnet
 id =
}

module "s3-bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "3.1.0"
  # insert the 7 required variables here
}

#autoscaling
module "autoscaling" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "6.3.0"
  # insert the 34 required variables here
  name = ""
}

#application load balancer
module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "6.8.0"
  name = "my-alb"
  load_balancer_type = "application"
  vpc_id = ""
}


module "security-group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.9.0"
  # insert the 3 required variables here
}

#relational database
module "rds" {
  source  = "terraform-aws-modules/rds/aws"
  version = "4.2.0"
  # insert the 38 required variables here
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "18.20.2"
  cluster_name = ""
  vpc_id = module.vpc
  subnet_id =
}

module "ec2-instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "3.5.0"
  name = ""
  instance_type = var.instance_type
  subnet_id = ""
  monitoring = true
  tags = {
    name = "ec2"
  }
}