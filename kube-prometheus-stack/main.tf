###
# module resources
###

resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = "monitoring"
  }
}

resource "helm_release" "kube_prometheus_stack" {
  name = "kube-prometheus-stack"

  repository = "https://prometheus-community.github.io/helm-charts"

  chart     = "kube-prometheus-stack"
  version   = "36.0.3"
  namespace = kubernetes_namespace.monitoring.metadata[0].name
  timeout   = 1200

  depends_on = [
    kubernetes_namespace.monitoring
  ]
}