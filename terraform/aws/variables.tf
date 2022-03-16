variable "aws_region"{
  type = string
  description = "Region for AWS Resources"
  default = "us-east-1"
}
variable "instance_type" {
  type        = string
  description = "Type for EC2 Instance"
  default     = "t2.micro"
}