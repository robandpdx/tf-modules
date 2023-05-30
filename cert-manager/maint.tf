resource "kubernetes_namespace" "cm" {
  metadata {
    name = "cert-manager"
  }
}
resource "helm_release" "cm" {
  name             = "cm"
  namespace        = kubernetes_namespace.cm.metadata[0].name
  create_namespace = false
  chart            = "cert-manager"
  repository       = "https://charts.jetstack.io"
  version          = "v1.12.1"
  values = [
    file("${path.module}/values.yaml")
  ]
}