variable "dns_name" {
  type = string
  default = "paszymaja.com."
  description = "name of the DNS entry"
}

variable "project_id" {
  type        = string
  description = "The project ID to create the cluster."
}

variable "region" {
  type        = string
  description = "The region to create the cluster."
}

variable "dns_zone_name" {
  type = string
  default = "paszymaja-zone"
  description = "name of the DNS zone"
}