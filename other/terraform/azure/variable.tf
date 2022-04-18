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
 default = "eastus"
}
variable "vnet_cidr_range"{

}
variable "vnet_id"{}
variable "vnet_name"{}
variable "public_subnet"{
type = string,

}
variable "private_subnet"{
 type = string,
}
variable "resource_group_name" {
  type = string,
  default = ""
}
variable "subnet_prefixes"{
  type = list(string)
}
variable "subnet_names" {
 type = string
}