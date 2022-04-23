resource "google_cloudfunctions_function" "kill_switch_func" {
  name        = "kill_switch"
  description = "Function used to disconnect billing account from project" 
  runtime     = "nodejs14"

  available_memory_mb   = 128
  timeout = 20
  source_archive_bucket = google_storage_bucket.kill_switch_bucket.name
  source_archive_object = google_storage_bucket_object.archive.name

    event_trigger {
    event_type = "providers/cloud.pubsub/eventTypes/topic.publish"
    resource   = google_pubsub_topic.kill_switch_topic.name
  }

  entry_point = "stopBilling"

}

resource "google_pubsub_topic" "kill_switch_topic" {
  name = "kill_switch_topic"
}

resource "google_storage_bucket" "kill_switch_bucket" {
  name = "kill_switch_bucket_main"
  location      = var.gcp_region
}

resource "google_storage_bucket_object" "archive" {
  name   = "function.zip"
  bucket = google_storage_bucket.kill_switch_bucket.name
  source = "./cloud_functions/kill_switch/function.zip"
}
