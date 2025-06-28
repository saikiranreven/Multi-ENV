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
          
          # Add health checks
          readiness_probe {
            http_get {
              path = "/"
              port = 80
            }
            initial_delay_seconds = 5
            period_seconds       = 10
          }
        }
      }
    }
    
    # Add deployment timeout
    min_ready_seconds = 30
  }

  timeouts {
    create = "10m"
    update = "10m"
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
  
  timeouts {
    create = "5m"
    update = "5m"
  }
}