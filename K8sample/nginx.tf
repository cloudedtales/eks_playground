resource "kubernetes_deployment" "nginx" {
  metadata {
    name = var.name
    labels = {
      App = var.app_name
    }
  }
  spec {
    replicas = var.replicas
    selector {
      match_labels = {
        App = var.app_name
      }
    }
    template {
      metadata {
        labels = {
          App = var.app_name
        }
      }
      spec {
        container {
          image = var.image
          name  = "example"
          port {
            container_port = 80
          }
          resources {
            limits {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "nginx" {
  metadata {
    name = var.name
  }
  spec {
    selector = {
      App = kubernetes_deployment.nginx.spec.0.template.0.metadata[0].labels.App
    }
    port {
      port        = 80
      target_port = 80
    }
    type = "LoadBalancer"
  }
}

output "url" {
  value = kubernetes_service.nginx.load_balancer_ingress[0].hostname
}