module "network" {
  source              = "Azure/network/azurerm"
  resource_group_name = azurerm_resource_group.example.name
  address_spaces      = var.address_spaces
  subnet_prefixes     = var.subnet_prefixes
  subnet_names        = var.subnet_names
  vnet_id = var.vnet_id

  subnet_service_endpoints = {
    "subnet1" : ["Microsoft.Sql"],
    "subnet2" : ["Microsoft.Sql"],
    "subnet3" : ["Microsoft.Sql"]
  }

  tags = {
    environment = "dev"
    costcenter  = "it"
  }

  depends_on = [azurerm_resource_group.example]
}
module "loadbalancer" {
  source  = "Azure/loadbalancer/azurerm"
  version = "3.4.0"
  # insert the 1 required variable here
  resource_group_name = ""
}
module "ecr" {
  source = "cloudposse/ecr/aws"
  # Cloud Posse recommends pinning every module to a specific version
  # version     = "x.x.x"
  namespace              = "eg"
  stage                  = "test"
  name                   = "ecr"
  principals_full_access = [data.aws_iam_role.ecr.arn]
}
module "web-app" {
  source  = "innovationnorway/web-app/azurerm"
  version = "1.0.3-alpha.1"
  # insert the 2 required variables here
}