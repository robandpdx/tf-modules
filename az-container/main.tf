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
  description = "DNS prefix to use for the container instance (not used with private IP)."
  default     = null
}

variable "environment_variables" {
  description = "Environment variables to use for the container instance."
  type        = map(string)
  default     = {}
}

variable "port" {
  description = "Port to use for the container instance."
  default     = 3000
}

variable "memory" {
  description = "Memory to use for the container instance."
  default     = "1.5"
}

variable "cpu" {
  description = "CPU to use for the container instance."
  default     = "1"
}

variable "secure_environment_variables" {
  description = "Environment variables to use for the container instance."
  type        = map(string)
  default     = {}
}

variable "vnet_address_space" {
  description = "Address space for the virtual network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subnet_address_prefix" {
  description = "Address prefix for the container subnet"
  type        = string
  default     = "10.0.1.0/24"
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "vnet" {
  name                = "${var.container_name}-vnet"
  address_space       = var.vnet_address_space
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "container_subnet" {
  name                 = "${var.container_name}-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.subnet_address_prefix]

  delegation {
    name = "container_group_delegation"
    service_delegation {
      name    = "Microsoft.ContainerInstance/containerGroups"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

resource "azurerm_network_profile" "container_profile" {
  name                = "${var.container_name}-profile"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  container_network_interface {
    name = "${var.container_name}-nic"

    ip_configuration {
      name      = "internal"
      subnet_id = azurerm_subnet.container_subnet.id
    }
  }
}

resource "azurerm_container_group" "container" {
  name                = var.container_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_address_type    = "Private"
  network_profile_id = azurerm_network_profile.container_profile.id
  os_type            = "Linux"

  container {
    name                         = var.container_name
    image                        = var.container_image
    cpu                          = var.cpu
    memory                       = var.memory
    environment_variables        = var.environment_variables
    secure_environment_variables = var.secure_environment_variables

    ports {
      port     = var.port
      protocol = "TCP"
    }
  }
}

output "container_instance_fqdn" {
  value = azurerm_container_group.container.fqdn
}

output "container_instance_ip" {
  value = azurerm_container_group.container.ip_address
}

output "virtual_network_id" {
  value = azurerm_virtual_network.vnet.id
}

output "subnet_id" {
  value = azurerm_subnet.container_subnet.id
}