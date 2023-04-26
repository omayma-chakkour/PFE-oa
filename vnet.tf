# Create a virtual network within the resource group

resource "azurerm_virtual_network" "Env-Vnet" {
  name                = var.Vnet_name
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = var.Vnet_subnet_address
  depends_on = [
    azurerm_resource_group.Monitoring_PFE2023
  ]
}

# create Subnets

resource "azurerm_subnet" "agsubnet" {
  name                 = var.ag_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.Env-Vnet.name
  address_prefixes     = var.ag_subnet_address
  depends_on = [
    azurerm_resource_group.Monitoring_PFE2023
  ]
}

resource "azurerm_subnet" "admin-Subnet" {
  name                 = var.admin_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.Env-Vnet.name
  address_prefixes     = var.admin_subnet_address
  depends_on = [
    azurerm_resource_group.Monitoring_PFE2023
  ]
}
resource "azurerm_subnet" "monitoring-Subnet" {
  name                 = var.monitoring_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.Env-Vnet.name
  address_prefixes     = var.monitoring_subnet_address
  depends_on = [
    azurerm_resource_group.Monitoring_PFE2023
  ]
}