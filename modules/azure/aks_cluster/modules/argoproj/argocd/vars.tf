
variable "name" {
  type        = string
  default     = "argocd"
  description = "ArgoCD name"
}

variable "repository" {
  type        = string
  default     = "https://argoproj.github.io/argo-helm"
  description = "Repository helm to install Argo CD"
}

variable "chart" {
  type        = string
  default     = "argo-cd"
  description = "Chart of helm"
}

variable "chart_version" {
  type        = string
  default     = "7.5.2"
  description = "Chart version"
}

variable "namespace" {
  type        = string
  default     = "argoproj"
  description = "Namespace"
}

variable "installCRDs" {
  type        = bool
  default     = true
  description = "Enabled  install installCRDs"
}

variable "create_namespace" {
  type        = bool
  default     = true
  description = "Enable create a namespace"
}

variable "labels" {
  type        = map(string)
  description = "Labels to registry in Backstage and Cloud resources"
  default     = {}
}