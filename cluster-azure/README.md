## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |
| <a name="provider_local"></a> [local](#provider\_local) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_container_registry.acr](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry) | resource |
| [azurerm_kubernetes_cluster.aks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster) | resource |
| [azurerm_kubernetes_cluster_node_pool.aks_node_pool_1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster_node_pool) | resource |
| [azurerm_role_assignment.web_app_routing_dns_zone_contributor](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_resource_group.aks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [local_file.kubeconfig](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | Development environment for resource; prod, non-prod, shared-services | `string` | n/a | yes |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | Version of Kubernetes specified when creating the AKS managed cluster. If not specified, the latest recommended version will be used at provisioning time (but won't auto-upgrade). | `string` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | Geographic region resource will be deployed into | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | A short pre-defined text to identify the resource type | `string` | `"aks"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(any)` | `{}` | no |
| <a name="input_vm_size"></a> [vm\_size](#input\_vm\_size) | (Required) The size of the Virtual Machine, such as Standard\_DS2\_v2. | `string` | `"Standard_DS2_v2"` | no |
| <a name="input_admin_group_object_ids"></a> [admin\_group\_object\_ids](#input\_admin\_group\_object\_ids) | List of Azure AD group object IDs that will have admin access to the cluster | `list(string)` | `[]` | no |
| <a name="input_azure_tenant_id"></a> [azure\_tenant\_id](#input\_azure\_tenant\_id) | Azure Tenant ID for the cluster | `string` | `null` | no |
| <a name="input_kubeconfig_file"></a> [kubeconfig\_file](#input\_kubeconfig\_file) | The path to the kubeconfig file generated. | `string` | `"./kubeconfig"` | no |
| <a name="input_web_app_routing_default_nginx_controller"></a> [web\_app\_routing\_default\_nginx\_controller](#input\_web\_app\_routing\_default\_nginx\_controller) | Default ingress exposure mode for the AKS Application Routing NGINX controller. | `string` | `"AnnotationControlled"` | no |
| <a name="input_web_app_routing_dns_zone_ids"></a> [web\_app\_routing\_dns\_zone\_ids](#input\_web\_app\_routing\_dns\_zone\_ids) | List of Azure DNS zone resource IDs to attach to the AKS Application Routing add-on. Leave empty to enable the add-on without Azure DNS integration. | `list(string)` | `[]` | no |
| <a name="input_web_app_routing_enabled"></a> [web\_app\_routing\_enabled](#input\_web\_app\_routing\_enabled) | Enable the AKS Application Routing add-on. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_client_certificate"></a> [client\_certificate](#output\_client\_certificate) | n/a |
| <a name="output_client_key"></a> [client\_key](#output\_client\_key) | n/a |
| <a name="output_cluster_ca_certificate"></a> [cluster\_ca\_certificate](#output\_cluster\_ca\_certificate) | n/a |
| <a name="output_fqdn"></a> [fqdn](#output\_fqdn) | n/a |
| <a name="output_host"></a> [host](#output\_host) | n/a |
| <a name="output_id"></a> [id](#output\_id) | n/a |
| <a name="output_kube_config"></a> [kube\_config](#output\_kube\_config) | n/a |
| <a name="output_password"></a> [password](#output\_password) | n/a |
| <a name="output_username"></a> [username](#output\_username) | n/a |
| <a name="output_web_app_routing_enabled"></a> [web\_app\_routing\_enabled](#output\_web\_app\_routing\_enabled) | n/a |
| <a name="output_web_app_routing_identity"></a> [web\_app\_routing\_identity](#output\_web\_app\_routing\_identity) | n/a |

## Notes

- Set `web_app_routing_enabled = true` to enable the AKS Application Routing add-on.
- If you pass Azure DNS zone IDs in `web_app_routing_dns_zone_ids`, the module grants the add-on identity the `DNS Zone Contributor` role on each zone.
- Leave `web_app_routing_dns_zone_ids = []` to enable the add-on without Azure DNS integration.
