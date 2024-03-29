###
# module resources
###

resource "azurerm_resource_group" "aks" {
  name     = "rg-${var.prefix}-${var.environment}-${var.location}"
  location = var.location
  tags     = var.tags
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                      = "${var.prefix}-${var.environment}-${azurerm_resource_group.aks.location}"
  location                  = azurerm_resource_group.aks.location
  resource_group_name       = azurerm_resource_group.aks.name
  node_resource_group       = "${azurerm_resource_group.aks.name}-nodes"
  kubernetes_version        = var.kubernetes_version
  dns_prefix                = "dns-${var.prefix}-${var.environment}-${azurerm_resource_group.aks.location}"
  automatic_channel_upgrade = "stable"
  http_application_routing_enabled = true

  default_node_pool {
    name                         = "systempool"
    only_critical_addons_enabled = true
    vm_size                      = var.vm_size
    zones                        = [1, 2, 3]
    enable_auto_scaling          = true
    max_pods                     = 250
    max_count                    = 3
    min_count                    = 1
    node_count                   = 1
    tags                         = var.tags
  }

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}

#kubernetes_cluster_node_pool

resource "azurerm_kubernetes_cluster_node_pool" "aks_node_pool_1" {
  name                  = "userpool"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  vm_size               = var.vm_size
  zones                 = [1, 2, 3]
  enable_auto_scaling   = true
  max_count             = 10
  max_pods              = 250
  min_count             = 2
  node_count            = 2
  mode                  = "User"
  tags                  = var.tags
}

resource "local_file" "kubeconfig" {
    depends_on   = [azurerm_kubernetes_cluster.aks]
    filename     = var.kubeconfig_file
    content      = azurerm_kubernetes_cluster.aks.kube_config_raw
}

resource "azurerm_container_registry" "acr" {
  name                = "${var.prefix}ContainerRegistry"
  resource_group_name = azurerm_resource_group.aks.name
  location            = azurerm_resource_group.aks.location
  sku                 = "Basic"
  admin_enabled       = false
}
