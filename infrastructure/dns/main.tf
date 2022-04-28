resource "google_dns_managed_zone" "paszymaja-zone" {
  name        = "paszymaja-zone"
  dns_name    = "paszymaja.com."
  description = "paszymaja DNS zone"
}