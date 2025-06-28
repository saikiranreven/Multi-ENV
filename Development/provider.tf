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

provider "kubernetes" {
  host                   = "https://${google_container_cluster.dev.endpoint}"
  cluster_ca_certificate = base64decode(google_container_cluster.dev.master_auth[0].cluster_ca_certificate)
  token                  = data.google_client_config.default.access_token
}

data "google_client_config" "default" {}