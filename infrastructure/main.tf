module "kill_switch" {
  source = "./kill_switch/"
  region = var.region
}
module "network" {
  source     = "./network/"
  project_id = var.project_id
  region     = var.region
}

module "dns" {
  source = "./dns/"
}

module "k8s_cluster" {
  source             = "./k8s_cluster/"
  credentials        = var.gcp_credentials
  region             = var.region
  zones              = var.zones
  name               = var.name
  project_id         = var.project_id
  machine_type       = var.machine_type
  min_count          = var.min_count
  max_count          = var.max_count
  disk_size_gb       = var.disk_size_gb
  initial_node_count = var.initial_node_count

  network    = module.network.network_name
  subnetwork = module.network.subnetwork_name
}
