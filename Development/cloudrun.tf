resource "google_cloud_run_service" "welcome_service" {
  name     = "welcome-service"
  location = "us-central1"

  template {
    spec {
      containers {
        image = "gcr.io/${var.project_id}/welcome-app:${var.image_tag}"
        ports {
          container_port = 8080
        }
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

resource "google_cloud_run_service_iam_member" "public_access" {
  service  = google_cloud_run_service.welcome_service.name
  location = google_cloud_run_service.welcome_service.location
  role     = "roles/run.invoker"
  member   = "allUsers"
}

output "service_url" {
  value = google_cloud_run_service.welcome_service.status[0].url
}

variable "project_id" {
  description = "Google Cloud Project ID"
  default     = "project-bct-463501"
}

variable "image_tag" {
  description = "Docker image tag"
  default     = "latest"
}