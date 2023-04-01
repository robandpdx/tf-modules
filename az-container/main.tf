variable "resource_group_name" {
  description = "Name of the resource group where the container instance will be deployed."
}

variable "location" {
  description = "Location where the container instance will be deployed."
}

variable "container_image" {
  description = "Docker image to use for the container instance."
}

variable "container_name" {
  description = "Name to use for the container instance."
}
variable "dns_prefix" {
  description = "DNS prefix to use for the container instance."
}

variable "secure_environment_variables" {
  description = "Environment variables to use for the container instance."
  type = map(string)
  default = {}
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_container_group" "container" {
  name                = var.container_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_address_type     = "Public"
  dns_name_label      = "${var.dns_prefix}"
  os_type = "Linux"

  container {
    name   = var.container_name
    image  = var.container_image
    cpu    = "1"
    memory = "1.5"
    secure_environment_variables = "${var.secure_environment_variables}"

    ports {
      port     = 3000
      protocol = "TCP"
    }
  }
}

output "container_instance_fqdn" {
  value = azurerm_container_group.container.fqdn
}