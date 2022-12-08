## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | n/a |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | n/a |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.linkerd](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.linkerd_viz](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_labels.pod_injectoin_label](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/labels) | resource |
| [kubernetes_namespace.test](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [null_resource.canary](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.flagger](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.loadtester](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.podinfo](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cert_pem"></a> [cert\_pem](#input\_cert\_pem) | n/a | `any` | n/a | yes |
| <a name="input_issuer_cert_pem"></a> [issuer\_cert\_pem](#input\_issuer\_cert\_pem) | n/a | `any` | n/a | yes |
| <a name="input_issuer_cert_validity_end_time"></a> [issuer\_cert\_validity\_end\_time](#input\_issuer\_cert\_validity\_end\_time) | n/a | `any` | n/a | yes |
| <a name="input_issuer_key_pem"></a> [issuer\_key\_pem](#input\_issuer\_key\_pem) | n/a | `any` | n/a | yes |

## Outputs

No outputs.
