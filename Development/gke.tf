resource "google_container_cluster" "cluster" {
  name     = "dev-cluster"
  location = "us-central1"
  
  node_pool {
    node_config {
      machine_type = "e2-small"
      oauth_scopes = [
        "https://www.googleapis.com/auth/logging.write",
        "https://www.googleapis.com/auth/monitoring"
      ]
    }
  }
}

resource "kubernetes_deployment" "app" {
  metadata {
    name = "hello-app"
  }
  spec {
    replicas = 1
    template {
      container {
        image = "nginx:alpine"
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
    name = "web-service"
  }
  spec {
    type = "LoadBalancer"
    selector = {
      app = kubernetes_deployment.app.metadata[0].labels.app
    }
    port {
      port        = 80
      target_port = 80
    }
  }
}