resource "google_cloud_run_service" "welcome_service" {
  name     = "welcome-service-prod"
  location = "us-central1"

  template {
    spec {
      containers {
        image = "gcr.io/project-bct-463501/welcome-app:prod"
        
      }
    }
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