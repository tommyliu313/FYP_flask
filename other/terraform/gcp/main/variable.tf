variable "subscription_id" {
  type = string
}
variable "client_id"{

}
variable "client_secret"{

}
variable "location"{
 type = string
 default = "eastus"
}
variable "vnet_cidr_range"{

}
variable "subnet_prefixes"{
  type = list(string)
}

variable "subnet_names" {

}


variable "public_subnet"{
type = string
}

variable "private_subnet"{
 type = string,
}

variable "project_id"{

}