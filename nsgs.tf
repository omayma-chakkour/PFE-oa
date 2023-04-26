#azure security group
#admin NSG
resource "azurerm_network_security_group" "Admin-Nsg" {
  name                = "Admin-Nsg"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "Allow-ssh"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  depends_on = [
    azurerm_resource_group.Monitoring_PFE2023
  ]
  tags = {
    environment = "PFE2023_CHAKKOUR_AIT_AHMED"
  }
}

#monitoring NSG

resource "azurerm_network_security_group" "Monitoring-Nsg" {
  name                = "Monitoring-Nsg"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "allow-ssh"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  depends_on = [
    azurerm_resource_group.Monitoring_PFE2023
  ]
  tags = {
    environment = "PFE2023_CHAKKOUR_AIT_AHMED"
  }
}

# Resource-3: Create Network Security Group (NSG)

resource "azurerm_network_security_group" "ag_subnet_nsg" {
  name                = "ag_subnet_nsg"
  location            = var.location
  resource_group_name = var.resource_group_name
  depends_on = [
    azurerm_resource_group.Monitoring_PFE2023
  ]
  tags = {
    environment = "PFE2023_CHAKKOUR_AIT_AHMED"
  }
}
resource "azurerm_network_security_rule" "ag_nsg_rule" {
  for_each                    = local.ag_inbound_ports_map
  name                        = "Allow-${each.value}"
  priority                    = each.key
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.value
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.ag_subnet_nsg.name
  depends_on = [
    azurerm_resource_group.Monitoring_PFE2023
  ]
}



#association des NSG au sunets

resource "azurerm_subnet_network_security_group_association" "Nsg-Subnet-Admin" {
  subnet_id                 = azurerm_subnet.admin-Subnet.id
  network_security_group_id = azurerm_network_security_group.Admin-Nsg.id
}

resource "azurerm_subnet_network_security_group_association" "Nsg-Subnet-Monitoring" {
  subnet_id                 = azurerm_subnet.monitoring-Subnet.id
  network_security_group_id = azurerm_network_security_group.Monitoring-Nsg.id
}
resource "azurerm_subnet_network_security_group_association" "ag_subnet_nsg_association" {
  subnet_id                 = azurerm_subnet.agsubnet.id
  network_security_group_id = azurerm_network_security_group.ag_subnet_nsg.id
}
