terraform {
  backend "gcs" {
    bucket = "project-bct-tf-state"
    prefix = "terraform/state"
  }
}

required_providers {
    google = {
      source = "hashicorp/google"
    }
    random = {
      source = "hashicorp/random"
    }
  }
}

provider "google" {
  project = "project-bct-463501"
  region  = "us-central1"
}