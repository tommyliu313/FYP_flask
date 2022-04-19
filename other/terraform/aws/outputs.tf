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

output "cluster_id"{
  value = module.eks.cluster_id
}

output "region"{
  value = var.aws_region
}

output "cluster_name"{
  value = module.eks.cluster_name
}
output "instance_private_ip"{
  value = aws_instance
}