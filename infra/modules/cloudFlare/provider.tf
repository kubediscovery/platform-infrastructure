terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "5.0.0-alpha1"
    }
  }
}

provider "cloudflare" {
  # api_token = var.cloudflare_api_token
  api_key   = "0779e506ac8d0586b70ab673ee63db95f245f"
  email     = "rafael.tomelin@gmail.com"
}

variable "cloudflare_api_token" {
  description = "Cloudflare API token"
  type        = string
  default     = "-xHhxITj7Aeii5f37RVBM_1E-L69JBb0aeOLsq6t"
}