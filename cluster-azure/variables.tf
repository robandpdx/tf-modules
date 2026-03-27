###
# module inputs
###

variable "environment" {
  description = "Development environment for resource; prod, non-prod, shared-services"
  type        = string
}

variable "location" {
  description = "Geographic region resource will be deployed into"
  type        = string
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(any)
  default     = {}
}

variable "prefix" {
  description = "A short pre-defined text to identify the resource type"
  type        = string
  default     = "aks"
}

#kubernetes_cluster

variable "kubernetes_version" {
  description = "Version of Kubernetes specified when creating the AKS managed cluster. If not specified, the latest recommended version will be used at provisioning time (but won't auto-upgrade)."
  type        = string
  default     = null
}

variable "vm_size" {
  description = "(Required) The size of the Virtual Machine, such as Standard_DS2_v2."
  type        = string
  default     = "Standard_DS2_v2"
}

variable "kubeconfig_file" {
  description = "The path to the kubeconfig file generated."
  type        = string
  default     = "./kubeconfig"
}

variable "admin_group_object_ids" {
  description = "List of Azure AD group object IDs that will have admin access to the cluster"
  type        = list(string)
  default     = []
}

variable "azure_tenant_id" {
  description = "Azure Tenant ID for the cluster"
  type        = string
  default     = null
}

variable "web_app_routing_enabled" {
  description = "Enable the AKS Application Routing add-on."
  type        = bool
  default     = false
}

variable "web_app_routing_dns_zone_ids" {
  description = "List of Azure DNS zone resource IDs to attach to the AKS Application Routing add-on. Leave empty to enable the add-on without Azure DNS integration."
  type        = list(string)
  default     = []
}

variable "web_app_routing_default_nginx_controller" {
  description = "Default ingress exposure mode for the AKS Application Routing NGINX controller."
  type        = string
  default     = "AnnotationControlled"

  validation {
    condition     = contains(["None", "Internal", "External", "AnnotationControlled"], var.web_app_routing_default_nginx_controller)
    error_message = "web_app_routing_default_nginx_controller must be one of None, Internal, External, or AnnotationControlled."
  }
}