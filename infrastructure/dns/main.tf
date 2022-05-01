resource "google_dns_managed_zone" "paszymaja-zone" {
  name        = var.dns_zone_name
  dns_name    = var.dns_name
  description = "paszymaja DNS zone"
}

resource "google_dns_record_set" "dns-A" {
  name         = var.dns_name
  managed_zone = var.dns_zone_name
  type         = "A"
  ttl          = 300

  rrdatas = [google_compute_address.public_ip_address.address]
}

# resource "google_dns_record_set" "dns-NS" {
#   name         = var.dns_name
#   managed_zone = var.dns_zone_name
#   type         = "NS"
#   ttl          = 300

#   rrdatas = ["ns-cloud-d1.googledomains.com.",
#     "ns-cloud-d2.googledomains.com.",
#     "ns-cloud-d3.googledomains.com.",
#     "ns-cloud-d4.googledomains.com."]
# }

resource "google_compute_address" "public_ip_address" {
  provider     = google-beta
  name         = "paszymaja-ip"
  address_type = "EXTERNAL"
  project      = var.project_id
  region       = var.region
}
