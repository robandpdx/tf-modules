# Example usage of the az-container module with VPC

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

module "container" {
  source = "../"

  # Required variables
  resource_group_name = "example-container-rg"
  location           = "East US"
  container_name     = "example-app"
  container_image    = "nginx:latest"

  # Optional VNet configuration (using defaults if not specified)
  vnet_address_space     = ["10.1.0.0/16"]
  subnet_address_prefix  = "10.1.1.0/24"

  # Optional container configuration
  port   = 80
  cpu    = "0.5"
  memory = "1.0"

  environment_variables = {
    ENV        = "production"
    APP_NAME   = "example-nginx"
  }
}

# Outputs to demonstrate the VPC integration
output "container_private_ip" {
  description = "Private IP address of the container instance"
  value       = module.container.container_instance_ip
}

output "virtual_network_id" {
  description = "ID of the Virtual Network containing the container"
  value       = module.container.virtual_network_id
}

output "subnet_id" {
  description = "ID of the subnet containing the container"
  value       = module.container.subnet_id
}