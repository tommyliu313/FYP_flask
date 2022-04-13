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