#monitoring cloudwatch
module "cloudwatch" {
  source  = "terraform-aws-modules/cloudwatch/aws"
  version = "2.5.0"
}

#virtual private cloud
module "vpc"{
 source = "terraform-aws-modules/vpc/aws"
 version = "2.66.0"
 name = "my-vpc"
 cidr = var.cidr_block
 azs = ["${var.aws_region}a","${var.aws_region}b"]
 private_subnets = var.private_subnets
 public_subnets = var.public_subnets
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
  subnet = [var.public_subnets[0],var.public_subnets[1]]
  vpc_id = module.vpc.vpc_id
}

# security group
module "security-group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.9.0"
  # insert the 3 required variables here
}

#relational database
module "rds" {
  source  = "terraform-aws-modules/rds/aws"
  version = "4.2.0"

  # database engine
  engine = "mysql"
  engine_version = ""
  instance_class = ""
  allocated_storage = 3

  # database info
  db_name = ""
  username = ""
  port = "3306"
  identifier = ""
}

#kubernetes service
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "18.20.2"
  cluster_name = var.kubernetes_settings.clustername
  cluster_version = ""
  cluster_endpoint_private_access = true
  subnets = module.vpc.private_subnets
  vpc_id = module.vpc.vpc_id
  worker_groups = [
    {
      name = "worker-group01"
      instance_type = "t2.small"
      additional_userdata = "N/A"
      asg_desired_capacity = 1

    }
  ]
}

#ec2
module "ec2-instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "3.5.0"
  name = "ec2"
  instance_type = var.instance_type
  subnet_id = ""
  monitoring = true
  tags = {
    name = "ec2"
  }
}