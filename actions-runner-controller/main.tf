###
# module resources
###

resource "kubernetes_namespace" "arc-systems" {
  metadata {
    name = "arc-systems"
  }
}

resource "kubernetes_secret" "controller-manager" {
  metadata {
    name      = "controller-manager"
    namespace = kubernetes_namespace.arc-systems.metadata[0].name
  }
  data = {
    github_token = "${var.github_token}"
  }
  type = "Opaque"
}

resource "helm_release" "arc" {
  name = "arc"

  repository = "oci://ghcr.io/actions/actions-runner-controller-charts/actions-runner-controller-2"

  chart     = "arc"
  version   = "0.1.0"
  namespace = kubernetes_namespace.arc-systems.metadata[0].name
  timeout   = 300
}
