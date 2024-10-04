terraform {
  required_providers {   
     argocd = {
      source = "oboukili/argocd"
      version = "6.1.1"
    }
  }


}

provider "argocd" {

  server_addr = "localhost:8080"
  insecure    = true
  grpc_web    = true
  username = "tomelin"
  auth_token = var.argocd_password
  
}