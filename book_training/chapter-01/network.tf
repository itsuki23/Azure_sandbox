resource "azurerm_virtual_network" "virtualNetwork" {
  name                = var.virtual_network_name
  location            = var.location
  resource_group_name = azurerm_resource_group.resource_group.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "Public" {
  name                 = "Public"
  resource_group_name  = azurerm_resource_group.resource_group.name
  virtual_network_name = azurerm_virtual_network.virtualNetwork.name
  address_prefix       = "10.0.1.0/24"
}

resource "azurerm_subnet" "Private" {
  name                 = "Private"
  resource_group_name  = azurerm_resource_group.resource_group.name
  virtual_network_name = azurerm_virtual_network.virtualNetwork.name
  address_prefix       = "10.0.2.0/24"
}


