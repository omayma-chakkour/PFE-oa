
#### creation des vm ####
# 1-interfece reseau d la vm NIC ou on va attacher la publique IP
########## admin nic 
resource "azurerm_network_interface" "admin-Nic" {
  name                = "admin-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "admin-pub-ip"
    subnet_id                     = azurerm_subnet.admin-Subnet.id
    private_ip_address_allocation = var.private_ip_address_allocation
    public_ip_address_id          = azurerm_public_ip.admin-vm-pip.id
  }
  depends_on = [
    azurerm_resource_group.Monitoring_PFE2023
  ]
  tags = {
    environment = "PFE2023_CHAKKOUR_AIT_AHMED"
  }
}
###### ELK VL SUBNET
resource "azurerm_network_interface" "ELK-Nic" {
  name                = "ELK-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "elk-ip"
    subnet_id                     = azurerm_subnet.monitoring-Subnet.id
    private_ip_address_allocation = var.private_ip_address_allocation
  }
}

#### Grafana NIC
resource "azurerm_network_interface" "Grafana-Nic" {
  name                = "Grafana-nic"
  location            = var.location
  resource_group_name = var.resource_group_name
  depends_on = [
    azurerm_resource_group.Monitoring_PFE2023
  ]
  tags = {
    environment = "PFE2023_CHAKKOUR_AIT_AHMED"
  }

  ip_configuration {
    name                          = "grafana-ip"
    subnet_id                     = azurerm_subnet.monitoring-Subnet.id
    private_ip_address_allocation = var.private_ip_address_allocation
  }
}


#### 2- creation des vms

#VM ADMIN

resource "azurerm_virtual_machine" "admin-vm" {
  name                  = "admin-vm"
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.admin-Nic.id]
  vm_size               = var.vm_size



  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = var.vm-sku
    version   = "latest"
  }
  storage_os_disk {
    name              = "admin-vm-os-disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = var.disk-type
  }
  os_profile {
    computer_name  = "admin-vm"
    admin_username = "userAdmin"
    admin_password = "Password1234!"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }

  depends_on = [
    azurerm_resource_group.Monitoring_PFE2023
  ]
  tags = {
    environment = "PFE2023_CHAKKOUR_AIT_AHMED"
  }
  provisioner "remote-exec" {
    connection {
      type     = "ssh"
      user     = "userAdmin"
      password = "Password1234!"
      host     = azurerm_public_ip.admin-vm-pip.ip_address

    }
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y software-properties-common",
      "sudo apt-add-repository -y ppa:ansible/ansible",
      "sudo apt-get update",
      "sudo apt-get install -y ansible"
    ]
  }
}

################ vm ELK 
resource "azurerm_virtual_machine" "ELK-vm" {
  name                  = "ELK-vm"
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.ELK-Nic.id]
  vm_size               = var.vm_size



  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = var.vm-sku
    version   = "latest"
  }
  storage_os_disk {
    name              = "elk-os-disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = var.disk-type
  }
  os_profile {
    computer_name  = "elk-vm"
    admin_username = "elkadmin"
    admin_password = "Password1234!"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  depends_on = [
    azurerm_resource_group.Monitoring_PFE2023
  ]
  tags = {
    environment = "PFE2023_CHAKKOUR_AIT_AHMED"
  }
}

############## grafana vm
resource "azurerm_virtual_machine" "grafana-vm" {
  name                  = "grafana-vm"
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.Grafana-Nic.id]
  vm_size               = var.vm_size



  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = var.vm-sku
    version   = "latest"
  }
  storage_os_disk {
    name              = "grafana-os-disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = var.disk-type
  }
  os_profile {
    computer_name  = "grafana-vm"
    admin_username = "grafanaadmin"
    admin_password = "Password1234!"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  depends_on = [
    azurerm_resource_group.Monitoring_PFE2023
  ]
  tags = {
    environment = "PFE2023_CHAKKOUR_AIT_AHMED"
  }
}


















