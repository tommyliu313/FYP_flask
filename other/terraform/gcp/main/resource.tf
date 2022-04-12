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
}
