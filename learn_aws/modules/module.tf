module "network" {
  source = "./network"

  cidr_block   = var.cidr_block
  project_name = var.project_name
  tags         = var.tags
}

module "cluster" {
  source = "./clusters"

  project_name     = var.project_name
  tags             = var.tags
  public_subnet_1a = module.network.subnet_pub_1a
  public_subnet_1b = module.network.subnet_pub_1b
}

module "managed_node_group" {
  source = "./managed-node-group"

  project_name = var.project_name
  tags         = var.tags
  cluster_name = module.cluster.cluster_name
  subnet_ids   = [module.network.subnet_priv_1a, module.network.subnet_priv_1b]
}

module "lb_controller" {
  source = "./lb-controller"

  project_name = var.project_name
  tags         = var.tags
}