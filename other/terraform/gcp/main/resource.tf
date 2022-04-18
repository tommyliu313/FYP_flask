# initial settings
resource "google_compute_network" "default"{
  name = var.network_name
}
resource "google_compute_subnetwork" "default"{
  name = var.network_name
  ip_cidr_range = var.vnet_cidr_range
  network = var.network
  region = var.region

}
resource "google_compute_address" "default"{
  name = var.network_name
  region = var.region
}

# ec2
resource "google.compute_instance" "terraform"{
  project = var.project_id
  name = ""
  machine_type = var.machine_type
  zone = var.zone
}

# container
resource "google_container_cluster" "default"{
name = var.network_name
location = var.location
initial_node_count = 3
min_master_version = data.google_container_engine_versions.default.latest_master_version
network = google_compute_subnetwork.default.name
subnetwork = google_compute_subnetwork.default.name
enable_legacy_abac = true
provisioner "local-exec"{
when = destroy
command = "sleep 90"
}
}

#cloud logging
resource "google_logging_metric" "logging_metric" {
  name = ""
  filter = ""
}

# kubernetes
resource "kubernetes_namespace" "staging"{
metadata{
name = "staging"
}
}
resource "kubernetes_service" "nginx"{

metadata{
namespace = kubernetes_namespace.staging.metadata[0].name
name = "nginx"
}
spec {
selector = {
run = "nginx"
}
session_affinity = "ClientIP"

port {
protocol = "TCP"
port = 80
target_port = 80
}
  type = "LoadBalancer"
  load_balancer_ip = google_compute_address.default.address
}
}
resource "kubernetes_replication_controller" "nginx"{
  metadata{
    name = "nginx"
    namespace = kubernetes_namespace.staging.metadata[0].name
    labels = {
      run = "nginx"
    }
  }
  spec{
    selector = {
      run = "nginx"
    }
    template {
      container{
        image = "nginx:latest"
        name = "nginx"

        resources{
          limits{
            cpu = "0.5"
            memory = "512Mi"
          }
          requests{
            cpu = "250m"
            memory = "50Mi"
          }
        }
      }
      metadata {}
      spec {}
    }
  }}