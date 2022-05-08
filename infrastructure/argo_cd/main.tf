data "kubectl_path_documents" "argo" {
  pattern = "${path.module}/manifests/*.yaml"
}

resource "kubernetes_namespace" "namespace" {
  metadata {
    name = "argo"
  }
}

resource "kubectl_manifest" "argo" {
  depends_on = [
    kubernetes_namespace.namespace,
  ]
  count = length(
    flatten(
      toset([
        for f in fileset(".", data.kubectl_path_documents.argo.pattern) : split("\n---\n", file(f))
        ]
      )
    )
  )
  yaml_body          = element(data.kubectl_path_documents.argo.documents, count.index)
  override_namespace = "argo"
}

terraform {
  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "1.14.0"
    }
  }
}
