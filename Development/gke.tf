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
          name  = "nginx"
          image = "nginx:alpine"
          port {
            container_port = 80
          }
        }
      }
    }
  }

  # Wait for cluster to be fully ready
  depends_on = [
    google_container_cluster.dev,
    kubernetes_config_map.app_config
  ]
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

  # Wait for deployment to be ready
  depends_on = [kubernetes_deployment.app]
}

# Add this config map to ensure proper initialization
resource "kubernetes_config_map" "app_config" {
  metadata {
    name = "app-config"
  }
  data = {
    "initialized" = "true"
  }
}