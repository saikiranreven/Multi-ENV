output "cluster_name" {
  value = google_container_cluster.dev.name
}

output "app_endpoint" {
  value = "http://${kubernetes_service.app.status[0].load_balancer[0].ingress[0].ip}"
}