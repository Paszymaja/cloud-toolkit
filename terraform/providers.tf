provider "google" {
  project = "main-348108"
  region  = "europe-central2"
}
terraform {
  backend "gcs" {
    bucket      = "main-tf-state"
    credentials = "account.json"
  }
}
