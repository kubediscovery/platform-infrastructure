terraform {
  required_providers {
    sonarcloud = {
      source  = "rewe-digital/sonarcloud"
      version = "0.5.2"
    }
  }
}

provider "sonarcloud" {
  organization = "synera-br"
  token        = "79a39a8ed9289da02051ed71eb66843fed540c92"
}

resource "sonarcloud_project" "example_project" {
  key        = "synera-br_teste-sonarcloud"
  name       = "teste-sonarcloud"
  visibility = "public"
}

resource "sonarcloud_project_main_branch" "main" {
  project_key = sonarcloud_project.example_project.id
  name        = "main"
}

# resource "fc-desafio-db" "Tomelin" {
#   # (resource arguments)
# }

# terraform import "sonarcloud_project_link.example_project" "fc-desafio-db,Tomelin"
resource "sonarcloud_project_link" "example_project" {
  # (resource arguments)
}