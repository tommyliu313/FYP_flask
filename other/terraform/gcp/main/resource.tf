resource "google.compute_instance" "terraform"{
  project = var.project_id
  name = ""
  machine_type = var.machine_type
  zone = var.zone
}
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
resource "google_logging_metric" "logging_metric" {
  name = ""
}