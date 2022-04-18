#configuration
variable "aws_region"{
  type = string
  description = "Region for AWS Resources"
  default = "us-east-1"
}
variable "aws_region2"{
  type = string
  description = "Region for AWS Resources"
  default = "us-east-2"
}
variable "access_key"{

}
variable "secret_key" {

}

# virtual network
variable "instance_type" {
  type        = string
  description = "Type for EC2 Instance"
  default     = "t2.micro"
}

variable "private_subnet"{
type = list(string)
default = ["10.0.2.0/24","10.0.4.0/24"]
}

variable "public_subnet"{
type = list(string)
default = ["10.0.0.0/24","10.0.1.0/24"]
}
variable "cidr_block"{
 default = "10.0.0.0/16"
}

variable "vpc_subnet_count"{
 type = map(number)
}
