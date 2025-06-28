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
          image = "nginx:alpine"  # Using static image for now
          port {
            container_port = 80
          }
        }
      }
    }
  }
}