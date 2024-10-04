

module "network" {
  source = "./network"

  project_name = var.project_name
  tags         = var.tags

}