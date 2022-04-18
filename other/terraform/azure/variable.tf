#configuration
variable "subscription_id" {
  type = string
}
variable "client_id"{
type = string
}
variable "client_secret"{

}
variable "location"{
 type = string
 default = "eastasia"
}

#virtual networking
variable "vnet_cidr_range"{

}
variable "vnet_id"{}
variable "vnet_name"{}
variable "public_subnet"{
type = string
default = ["10.0.0.0/24"]
}
variable "private_subnet"{
 type = string
}
variable "resource_group_name" {
  type = string
  default = ""
}
variable "subnet_prefixes"{
  type = list(string)
}
variable "subnet_names" {
 type = string
}

variable "kubernetes_settings"{
  name = "example-aks1"
  location = var.location
}