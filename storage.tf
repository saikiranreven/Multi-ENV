resource "google_storage_bucket" "storageBucket" {
  name          = "project_bucket_${random_id.suffix.hex}"
  location      = "us-central1"
}

resource "random_id" "suffix" {
  byte_length = 4
}

output "bucket_url" {
  value = "gs://${google_storage_bucket.project_bucket.name}"
}