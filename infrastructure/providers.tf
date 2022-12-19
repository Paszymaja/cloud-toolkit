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

provider "kubectl" {
  token = data.google_client_config.provider.access_token
  host  = "https://${module.k8s_cluster.endpoint}"
  cluster_ca_certificate = base64decode(
    module.k8s_cluster.ca_certificate,
  )
  load_config_file = false
}

provider "archive" {}
terraform {
  backend "gcs" {
    bucket      = "main-tf-state"
    credentials = "account.json"
  }
  required_providers {
    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.2.0"
    }

    google = {
      source  = "hashicorp/google"
      version = "~> 4.20.0"
    }

    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 4.46.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "1.14.0"
    }
  }

}


