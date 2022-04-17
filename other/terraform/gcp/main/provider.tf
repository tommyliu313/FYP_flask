provider "google" {
  project = var.project
  region  = var.region
  zone    = var.
}

provider "kubernetes"{
  version = "~> 1.21.0"
  host = google_container_cluster.default.endpoint
}
