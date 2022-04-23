provider "google" {
  project = "main-348108"
  region  = "europe-central2"
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
      version = "2.2.0"
    }

    google = {
      source = "hashicorp/google"
      version = "4.18.0"
    }
  }

}


