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
resource "azurerm_virtual_machine" "main"{
  name = ""
  location = azurerm_resource_group_app.location
  resource_group_name = azurerm_resource_group.app.name
  vm_size = "Standard_DS1_v2"
  network_interface_ids = []
  storage_os_disk {}
}
resource "azurerm_resource_group" "example" {
  name     = "my-resources"
  location = "West Europe"
}
resource "azurerm_virtual_network" "example"{
  name = ""
  address_space = [""]
  location =
  resource_group_name =
}
resource "azurerm_service_plan" "example"{
  name = ""
  resource_group_name = azurerm_resource_group.setup.name
  location = var.location
  sku_name = "P1v2"
}
resource "azurerm_windows_web_app" ""{

}
