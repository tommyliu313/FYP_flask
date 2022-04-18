provider "google" {
  project = var.project
  region  = var.region
  zone    = var.location
}

provider "kubernetes"{
  version = "~> 1.10.0"
  host = google_container_cluster.default.endpoint
  token = data.google_client_config.current.access_token
  client_certificate = base64encode(google_container_cluster.default.master_auth[0].client_certificate,)
  client_key = base64decode(google_container_cluster.default.master_auth[0].client_key)
  cluster_ca_certificate = base64decode(google_container_cluster.default.master_auth[0].cluster_ca_certificate,)
}
