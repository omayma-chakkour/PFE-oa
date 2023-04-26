# Create a resource group
resource "azurerm_resource_group" "Monitoring_PFE2023" {
  name     = var.resource_group_name
  location = var.location
  tags = {
    environment = "PFE2023_CHAKKOUR_AIT_AHMED"
  }
}