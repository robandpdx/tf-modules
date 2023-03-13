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