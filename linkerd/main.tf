###
# module resources
###

resource "helm_release" "linkerd" {
  name       = "linkerd"
  chart      = "linkerd2"
  repository = "https://helm.linkerd.io/stable"
  version    = "2.11.2"
  atomic     = true
  values = [
    file("${path.module}/values-ha.yaml")
  ]
  set {
    name  = "linkerdVersion"
    value = "stable-2.11.2"
  }
  set_sensitive {
    name  = "identityTrustAnchorsPEM"
    value = var.cert_pem
  }
  set {
    name  = "identity.issuer.crtExpiry"
    value = var.issuer_cert_validity_end_time
  }

  set {
    name  = "identity.issuer.tls.crtPEM"
    value = var.issuer_cert_pem
  }

  set {
    name  = "identity.issuer.tls.keyPEM"
    value = var.issuer_key_pem
  }
}

resource "kubernetes_labels" "pod_injectoin_label" {
  api_version = "v1"
  kind        = "Namespace"
  metadata {
    name = "kube-system"
  }
  labels = {
    "config.linkerd.io/admission-webhooks" : "disabled"
  }
}

resource "helm_release" "linkerd_viz" {
  depends_on = [helm_release.linkerd]

  name       = "viz"
  chart      = "linkerd-viz"
  repository = "https://helm.linkerd.io/stable"
  timeout    = "600"
}
# Local linkerd commands to know...
# linkerd check
# linkerd dashboard
# linkerd viz check
# linkerd viz dashboard

resource "null_resource" "flagger" {
  provisioner "local-exec" {
    command = "KUBECONFIG=./kubeconfig kubectl apply -k github.com/fluxcd/flagger//kustomize/linkerd?ref=main"
  }
  depends_on = [
    helm_release.linkerd
  ]
}

resource "kubernetes_namespace" "test" {
  metadata {
    name = "test"
    annotations = {
      "linkerd.io/inject" = "enabled"
    }
  }
  depends_on = [
    helm_release.linkerd,
    null_resource.flagger
  ]
}

resource "null_resource" "loadtester" {
  provisioner "local-exec" {
    command = "KUBECONFIG=./kubeconfig kubectl apply -k https://github.com/fluxcd/flagger//kustomize/tester?ref=main"
  }
  depends_on = [
    helm_release.linkerd,
    kubernetes_namespace.test
  ]
}

resource "null_resource" "podinfo" {
  provisioner "local-exec" {
    command = "KUBECONFIG=./kubeconfig kubectl apply -k https://github.com/fluxcd/flagger//kustomize/podinfo?ref=main"
  }
  depends_on = [
    helm_release.linkerd,
    kubernetes_namespace.test
  ]
}

resource "null_resource" "canary" {
  provisioner "local-exec" {
    command = "KUBECONFIG=./kubeconfig kubectl apply -f k8s-canary/podinfo-canary.yaml"
  }
  depends_on = [
    helm_release.linkerd,
    null_resource.flagger,
    kubernetes_namespace.test,
    null_resource.podinfo
  ]
}
