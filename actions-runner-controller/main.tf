###
# module resources
###

resource "kubernetes_namespace" "actions-runner-system" {
  metadata {
    name = "actions-runner-system"
  }
}

resource "kubernetes_secret" "controller-manager" {
  metadata {
    name      = "controller-manager"
    namespace = kubernetes_namespace.actions-runner-system.metadata[0].name
  }
  data = {
    github_token = "${var.github_token}"
  }
  type = "Opaque"
}

resource "helm_release" "actions-runner-controller" {
  name = "actions-runner-controller"

  repository = "https://actions-runner-controller.github.io/actions-runner-controller"

  chart     = "actions-runner-controller"
  namespace = kubernetes_namespace.actions-runner-system.metadata[0].name
  timeout   = 300
  set {
    name    = "githubWebhookServer.enabled"
    value   = "true"
  }
  set {
    name    = "authSecret.github_token"
    value   = "${var.github_token}"
  }
}
