#configuration
resource "azurerm_storage_account" "sa" {
  name                     = "${lower(var.naming_prefix)}${random_integer.sa_num.result}"
  resource_group_name      = azurerm_resource_group.setup.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

}
resource "azurerm_resource_group" "setup" {
  name     = var.resource_group_name
  location = var.location
}
#virtual network
resource "azurerm_virtual_machine" "main"{
  name = ""
  location = azurerm_resource_group_app.location
  resource_group_name = azurerm_resource_group.app.name
  vm_size = "Standard_DS1_v2"
  network_interface_ids = []
  storage_os_disk {}
}
resource "azurerm_virtual_network" "example"{
  name = "vnet"
  address_space = [""]
  location = azurerm_resource_group.setup.location
  resource_group_name = azurerm_resource_group.setup.name
}
resource "azurerm_subnet" "example"{
  name = "subnet"
  resource_group_name = azurerm_resource_group.setup.name
  virtual_network_name = azurerm_virtual_network.example.name
}
resource "azurerm_service_plan" "example"{
  name = ""
  resource_group_name = azurerm_resource_group.setup.name
  location = var.location
  sku_name = "P1v2"
}
resource "azurerm_windows_web_app" ""{

}

#monitoring
resource "azurerm_monitor_action_group" "" {

}
resource "azurerm_monitor_metric_alert" ""{

}