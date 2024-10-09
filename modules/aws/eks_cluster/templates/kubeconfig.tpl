apiVersion: v1
preferences: {}
kind: Config

clusters:
- cluster:
    server: ${endpoint}
    certificate-authority-data: ${cluster_auth_base64}
  name: ${cluster_arn}

contexts:
- context:
    cluster: ${cluster_arn}
    user: ${cluster_arn}
  name: ${cluster_arn}
current-context: ${cluster_arn}