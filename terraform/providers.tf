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
}
