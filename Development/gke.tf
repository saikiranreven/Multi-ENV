resource "google_container_cluster" "dev" {
  name     = "dev-cluster"  # Must match everywhere
  location = "us-central1"
}

resource "kubernetes_deployment" "app" {
  metadata {
    name = "hello-app"
    labels = {
      app = "hello"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "hello"
      }
    }
    template {
      metadata {
        labels = {
          app = "hello"
        }
      }
      spec {
        container {
          name  = "web"
          image = "gcr.io/${var.project_id}/hello-app:latest"
          port {
            container_port = 80
          }
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
    selector = {
      app = "hello"
    }
    port {
      port        = 80
      target_port = 80
    }
  }
}