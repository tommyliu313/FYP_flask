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
