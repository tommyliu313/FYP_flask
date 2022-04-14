module "cloudwatch" {
  source  = "terraform-aws-modules/cloudwatch/aws"
  version = "2.5.0"
}

module "vpc"{

}

module "web_app_s3" {
  source = "./modules/web-app-s3"

  bucket_name             = local.s3_bucket_name
  elb_service_account_arn = data.aws_elb_service_account.root.arn
  common_tags             = local.common_tags
}

module "autoscaling" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "6.3.0"
  # insert the 34 required variables here
  name = ""
}

module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "6.8.0"
  # insert the 4 required variables here
}

module "asg"{
  source = "terraform-aws-modules/autoscaling/aws"
  name = ""
  min_size =
  max_size =
  desired_capacity =

}