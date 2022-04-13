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
}