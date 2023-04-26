variable "resource_group_name" {
  type    = string
  default = "Monitoring-PFE2023"
}
variable "location" {
  type    = string
  default = "West Europe"
}
variable "Vnet_name" {
  type    = string
  default = "Env-Vnet"
}
variable "Vnet_subnet_address" {
  type    = list(string)
  default = ["10.0.0.0/16"]
}
variable "ag_subnet_name" {
  type    = string
  default = "agsubnet"
}
variable "ag_subnet_address" {
  type    = list(string)
  default = ["10.0.0.0/24"]
}
variable "admin_subnet_name" {
  type    = string
  default = "Admin-subnet"
}
variable "admin_subnet_address" {
  type    = list(string)
  default = ["10.0.1.0/24"]
}
variable "monitoring_subnet_name" {
  type    = string
  default = "monitoring-Subnet"
}
variable "monitoring_subnet_address" {
  type    = list(string)
  default = ["10.0.2.0/24"]
}
variable "private_ip_address_allocation" {
  default = "Dynamic"
}
variable "vm_size" {
  default = "Standard_B1s"

}
variable "ip_sku" {
  default = "Standard"
}
variable "allocation_method" {
  default = "Static"
}
variable "sku-app-gateway" {
  default = "Standard_v2"
}
variable "vm-sku" {
  default = "16.04-LTS"
}
variable "pip-dns" {
  default = "dns-pip-gateway"
}
variable "disk-type" {
  default = "Standard_LRS"
}