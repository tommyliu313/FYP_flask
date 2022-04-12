terraform {
  required_providers {
    google = {
      version = "~> 4.0.0"
    }
    google-beta = {
      version = "~> 4.0.0"
    }
  }
}
provider "google" {
  project = var.project
  region  = var.region
  zone    = var.zone
}

provider "kubernetes"{
  version = "~> 1.10.0"
  host = google_container_cluster.default.endpoint
}