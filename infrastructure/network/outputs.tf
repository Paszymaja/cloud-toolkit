output "network_name" {
    value = module.gcp-network.network_name
}

output "subnetwork_name" {
    value = module.gcp-network.subnets_names[0]
}