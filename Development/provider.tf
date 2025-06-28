terraform {
  backend "gcs" {
    bucket = "project-bct-tf-state"
    prefix = "dev/state"
  }
}

provider "google" {
  project = "project-bct-463501"
  region  = "us-central1"
}