module "gke" {
  source                     = "terraform-google-modules/kubernetes-engine/google"
  project_id                 = var.project_id
  regional                   = false
  region                     = var.region
  zones                      = var.zones
  name                       = var.name
  network                    = "default"
  subnetwork                 = "default"
  ip_range_pods              = ""
  ip_range_services          = ""
  http_load_balancing        = false
  horizontal_pod_autoscaling = true
  network_policy             = true
  logging_service            = "none"
  monitoring_service         = "none"
  remove_default_node_pool   = true
  create_service_account     = true
  grant_registry_access      = true


  node_pools = [
    {
      name               = "default-node-pool"
      machine_type       = var.machine_type
      min_count          = var.min_count
      max_count          = var.max_count
      disk_size_gb       = var.disk_size_gb
      disk_type          = "pd-standard"
      image_type         = "COS"
      auto_repair        = false
      auto_upgrade       = false
      service_account    = module.gke.service_account
      preemptible        = true
      initial_node_count = var.initial_node_count
    },
  ]
}

