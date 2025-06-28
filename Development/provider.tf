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

# Retrieve an access token as the Terraform runner
data "google_client_config" "provider" {}

data "google_container_cluster" "my_cluster" {
  name     = "my-cluster"
  location = "us-central1"
}

provider "kubernetes" {
  host  = "https://${data.google_container_cluster.my_cluster.endpoint}"
  token = data.google_client_config.provider.access_token
  cluster_ca_certificate = base64decode(
    data.google_container_cluster.my_cluster.master_auth[0].cluster_ca_certificate,
  )
}