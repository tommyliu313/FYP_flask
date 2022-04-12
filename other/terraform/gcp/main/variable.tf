variable "subscription_id" {
  type = string
}
variable "client_id"{

}
variable "client_secret"{

}
variable "location"{
 type = string
 default = "us-east-1a"
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
  default =
}

variable "project_id"{
type = string,

}
variable "machine_type"{
  type = string

}

variable "network_name"{
  default = "tf-gke-k8s"
}

variable "region"{
  default = "us-west1"
}