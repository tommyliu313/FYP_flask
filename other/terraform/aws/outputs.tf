output "vnet_id" {
  value = module.vnet-main.vnet_id
}

output "vnet_name" {
  value = module.vnet-main.vnet_name
}

output "resource_group_name" {
  value = local.full_rg_name
}

output "vpc_id"{
  value = module.vpc.vpc_id
}


