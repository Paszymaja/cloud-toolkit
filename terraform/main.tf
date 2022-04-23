module "kill-switch" {
    source = "./kill_switch/"
    gcp_region = var.gcp_region
}
