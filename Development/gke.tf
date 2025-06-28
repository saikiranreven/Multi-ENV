resource "google_container_cluster" "dev" {
  name     = "dev-cluster"
  location = "us-central1"
  
  node_pool {
    node_config {
      machine_type = "e2-small"
      oauth_scopes = ["https://www.googleapis.com/auth/cloud-platform"]
    }
  }
}

resource "kubernetes_deployment" "app" {
  metadata {
    name = "hello-app"
  }
  spec {
    template {
      container {
        image = "gcr.io/${var.project_id}/hello-app:latest"
        name  = "web"
        port {
          container_port = 80
        }
      }
    }
  }
}

resource "kubernetes_service" "app" {
  metadata {
    name = "hello-service"
  }
  spec {
    type = "LoadBalancer"
    port {
      port        = 80
      target_port = 80
    }
    selector = {
      app = kubernetes_deployment.app.metadata[0].labels.app
    }
  }
}