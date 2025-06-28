terraform {
  backend "gcs" {
    bucket = "project-bct-tf-state"
    prefix = "dev/state"
  }
}

provider "google" {
  project = var.project_id
  region  = "us-central1"
}

provider "kubernetes" {
  host                   = "https://${google_container_cluster.dev.endpoint}"
  cluster_ca_certificate = base64decode(google_container_cluster.dev.master_auth[0].cluster_ca_certificate)
  token                  = data.google_client_config.default.access_token
  
  # Add these configurations
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "gke-gcloud-auth-plugin"
  }
}