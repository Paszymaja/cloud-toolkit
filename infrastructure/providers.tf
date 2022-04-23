data "google_client_config" "provider" {}
provider "google" {
  credentials = "${file(var.credentials)}"
  project     = var.project_id
  region      = var.region
}

provider "google-beta" {
  credentials = "${file(var.credentials)}"
  project     = var.project_id
  region      = var.region
}

provider "kubernetes" {
  token                  = data.google_client_config.provider.access_token
  host                   = "https://${module.k8s_cluster.endpoint}"
  cluster_ca_certificate = base64decode(
    module.k8s_cluster.ca_certificate,
  )
}

provider "archive" {}
terraform {
  backend "gcs" {
    bucket      = "main-tf-state"
    credentials = "account.json"
  }
  required_providers {
    archive = {
      source = "hashicorp/archive"
      version = "~> 2.2.0"
    }

    google = {
      source = "hashicorp/google"
      version = "~> 4.18.0"
    }

    google-beta = {
      source = "hashicorp/google"
      version = "~> 4.18.0"
    }
  }

}


