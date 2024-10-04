output "argocd" {
  value       = nonsensitive(helm_release.argocd)
  sensitive = false
  description = "Result of installation a ArgoCD"
}
