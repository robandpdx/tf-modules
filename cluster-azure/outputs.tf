output "id" {
  value = azurerm_kubernetes_cluster.aks.id
}

output "kube_config" {
  value     = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive = true
}

output "client_key" {
  value     = azurerm_kubernetes_cluster.aks.kube_config.0.client_key
  sensitive = true
}

output "client_certificate" {
  value     = azurerm_kubernetes_cluster.aks.kube_config.0.client_certificate
  sensitive = true
}

output "cluster_ca_certificate" {
  value     = azurerm_kubernetes_cluster.aks.kube_config.0.cluster_ca_certificate
  sensitive = true
}

output "host" {
  value     = azurerm_kubernetes_cluster.aks.kube_config.0.host
  sensitive = true
}

output "username" {
  value     = azurerm_kubernetes_cluster.aks.kube_config.0.username
  sensitive = true
}

output "password" {
  value     = azurerm_kubernetes_cluster.aks.kube_config.0.password
  sensitive = true
}

output "fqdn" {
  value     = azurerm_kubernetes_cluster.aks.fqdn
}