resource "argocd_cluster" "this"{
  server = var.cluster_address
  name = var.cluster_name

  config {
    bearer_token = var.cluster_token
    tls_client_config {
      # insecure = true
      ca_data = base64decode(var.cluster_ca_certificate)
    }
  }
}