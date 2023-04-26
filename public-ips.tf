#creation of the public IPs

resource "azurerm_public_ip" "app-gateway-pip" {
  name                = "app-gateway-pip"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = var.allocation_method
  domain_name_label   = var.pip-dns
  sku                 = var.ip_sku
  depends_on = [
    azurerm_resource_group.Monitoring_PFE2023
  ]
  tags = {
    environment = "PFE2023_CHAKKOUR_AIT_AHMED"
  }
}

resource "azurerm_public_ip" "admin-vm-pip" {
  name                = "admin-vm-pip"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = var.allocation_method
  depends_on = [
    azurerm_resource_group.Monitoring_PFE2023
  ]
  tags = {
    environment = "PFE2023_CHAKKOUR_AIT_AHMED"
  }
}
