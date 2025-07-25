# Azure Container Module

This Terraform module creates an Azure Container Instance deployed within a Virtual Network (VNet) for enhanced security.

## Features

- Creates a dedicated Virtual Network and subnet for container instances
- Deploys container instances with private IP addresses
- Configures proper subnet delegation for Azure Container Instances
- Includes network profile for VNet integration

## Usage

```hcl
module "container" {
  source = "./az-container"

  resource_group_name = "my-rg"
  location           = "East US"
  container_name     = "my-app"
  container_image    = "nginx:latest"
  
  # Optional VNet configuration
  vnet_address_space     = ["10.0.0.0/16"]
  subnet_address_prefix  = "10.0.1.0/24"
  
  # Optional container configuration
  port   = 80
  cpu    = "1"
  memory = "1.5"
  
  environment_variables = {
    ENV = "production"
  }
}
```

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_container_group.container](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_group) | resource |
| [azurerm_network_profile.container_profile](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_profile) | resource |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_subnet.container_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_container_image"></a> [container\_image](#input\_container\_image) | Docker image to use for the container instance. | `string` | n/a | yes |
| <a name="input_container_name"></a> [container\_name](#input\_container\_name) | Name to use for the container instance. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Location where the container instance will be deployed. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the resource group where the container instance will be deployed. | `string` | n/a | yes |
| <a name="input_cpu"></a> [cpu](#input\_cpu) | CPU to use for the container instance. | `string` | `"1"` | no |
| <a name="input_dns_prefix"></a> [dns\_prefix](#input\_dns\_prefix) | DNS prefix to use for the container instance (not used with private IP). | `any` | `null` | no |
| <a name="input_environment_variables"></a> [environment\_variables](#input\_environment\_variables) | Environment variables to use for the container instance. | `map(string)` | `{}` | no |
| <a name="input_memory"></a> [memory](#input\_memory) | Memory to use for the container instance. | `string` | `"1.5"` | no |
| <a name="input_port"></a> [port](#input\_port) | Port to use for the container instance. | `number` | `3000` | no |
| <a name="input_secure_environment_variables"></a> [secure\_environment\_variables](#input\_secure\_environment\_variables) | Environment variables to use for the container instance. | `map(string)` | `{}` | no |
| <a name="input_subnet_address_prefix"></a> [subnet\_address\_prefix](#input\_subnet\_address\_prefix) | Address prefix for the container subnet | `string` | `"10.0.1.0/24"` | no |
| <a name="input_vnet_address_space"></a> [vnet\_address\_space](#input\_vnet\_address\_space) | Address space for the virtual network | `list(string)` | <pre>[<br>  "10.0.0.0/16"<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_container_instance_fqdn"></a> [container\_instance\_fqdn](#output\_container\_instance\_fqdn) | n/a |
| <a name="output_container_instance_ip"></a> [container\_instance\_ip](#output\_container\_instance\_ip) | n/a |
| <a name="output_subnet_id"></a> [subnet\_id](#output\_subnet\_id) | n/a |
| <a name="output_virtual_network_id"></a> [virtual\_network\_id](#output\_virtual\_network\_id) | n/a |

## Security

This module deploys container instances with private IP addresses within a Virtual Network, meeting security requirements by:

- Isolating containers within a dedicated VNet
- Using private IP addresses instead of public IPs
- Properly configuring subnet delegation for Azure Container Instances
- Providing network-level isolation and control