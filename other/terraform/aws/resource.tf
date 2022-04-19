#load balancer
resource "aws_lb" "nginx" {
  name               = "${local.name_prefix}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = module.vpc.public_subnets

  enable_deletion_protection = false

  access_logs {
    bucket  = module.web_app_s3.web_bucket.id
    prefix  = "alb-logs"
    enabled = true
  }

  tags = local.common_tags
}
resource "aws_lb_target_group" "nginx" {
  name     = "${local.name_prefix}-alb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id
}
resource "aws_lb_listener" "nginx" {
  load_balancer_arn = aws_lb.nginx.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nginx.arn
  }

  tags = local.common_tags
}
resource "aws_lb_target_group_attachment" "nginx" {
  count            = var.instance_count
  target_group_arn = aws_lb_target_group.nginx.arn
  target_id        = aws_instance.nginx[count.index].id
  port             = 80
}

#virtual network
resource "aws_vpc" "vpc"{
  cidr_block = var.cidr_block
  enable_dns_hostnames = true
  enable_dns_support = true
}
resource "aws_subnet" "main" {
  vpc_id = module.vpc.id
  cidr_block = "10.0.1.0/24"
}
#s3
resource "aws_s3_bucket_object" "website" {
  for_each = {
    website = "/website/index.html"
    logo    = "/website/Globo_logo_Vert.png"
  }
  bucket = module.web_app_s3.web_bucket.id
  key    = each.value
  source = ".${each.value}"

  tags = local.common_tags
}

#ec2
resource "aws_instance" "nginx" {
  count                  = var.instance_count
  ami                    = nonsensitive(data.aws_ssm_parameter.ami.value)
  instance_type          = var.instance_type
  subnet_id              = module.vpc.public_subnets[(count.index % var.vpc_subnet_count)]
  vpc_security_group_ids = [aws_security_group.nginx-sg.id]
  iam_instance_profile   = module.web_app_s3.instance_profile.name
  depends_on             = [module.web_app_s3]
  security_groups = ""
  user_data = templatefile("${path.module}/startup_script.tpl", { s3_bucket_name = module.web_app_s3.web_bucket.id })
  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-nginx-${count.index}"
  })

}

resource "aws_instance" "Bastion_host"{
  name = ""
}
resource "aws_internet_gateway" "gw" {
  vpc_id =
}


#security group
resource "aws_security_group" "nginx-sg" {
  name   = "${local.name_prefix}-nginx_sg"
  vpc_id = aws_vpc.vpc.id

  # HTTP access from VPC
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr_block]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = local.common_tags
}
resource "aws_security_group" "albsg"{
   name =
}
resource "aws_security_group" "bastionsg"{

}
resource "aws_security_group_rule" "example" {
  ingress{
    from_port = 80
    to_port = 80
    protocol = ""
    cidr_blocks =
  }
  egress{
    from_port = 80
    to_port = 80
    protocol = ""
    cidr_blocks =
  }
}

# database subnet group
resource "aws_db_subnet_group" "default" {
  name       = "main"
  subnet_ids = []

  tags = {
    Name = "My DB subnet group"
  }
}

#routetable
resource "aws_route_table" "public_route_table"{
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "public"
  }
}

resource "aws_route_table" "private_route_table"{
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "private"
  }
}

#eks
resource "aws_eks_cluster" "example"{

  name     = ""
  role_arn = ""
  vpc_config {}
}

#cloudwatch
resource "aws_cloudwatch_metric_alarm" "alarm"{

  alarm_name          = ""
  comparison_operator = ""
  evaluation_periods  = 0
}