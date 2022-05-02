data "google_client_config" "provider" {}
provider "google" {
  credentials = var.gcp_credentials
  project     = var.project_id
  region      = var.region
}

provider "google-beta" {
  credentials = var.gcp_credentials
  project     = var.project_id
  region      = var.region
}

provider "kubernetes" {
  token = data.google_client_config.provider.access_token
  host  = "https://${module.k8s_cluster.endpoint}"
  cluster_ca_certificate = base64decode(
    module.k8s_cluster.ca_certificate,
  )
}

provider "archive" {}
terraform {
  cloud {
    organization = "bombola"

    workspaces {
      name = "gh-actions"
    }
  }
  required_providers {
    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.2.0"
    }

    google = {
      source  = "hashicorp/google"
      version = "~> 4.19.0"
    }

    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 4.19.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
  }

}


