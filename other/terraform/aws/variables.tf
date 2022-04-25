#configuration
variable "aws_region"{
  type = string
  description = "Region for AWS Resources"
  default = "ap-east"
}
/*variable "access_key"{
 value = ""
}
variable "secret_key" {
 value = ""
}*/

# virtual network
variable "instance_type" {
  type        = string
  description = "Type for EC2 Instance"
  default     = "t2.micro"
}

variable "private_subnets"{
type = list(string)
default = ["10.0.2.0/24","10.0.4.0/24"]
}

variable "public_subnets"{
type = list(string)
default = ["10.0.0.0/24","10.0.1.0/24"]
}
variable "cidr_block"{
 default = "10.0.0.0/16"
}

variable "vpc_subnet_count"{
 type = map(number)
}

#kubernetes

