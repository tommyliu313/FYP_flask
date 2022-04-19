data "google_client_config" "provider" {}

data "google_container_cluster" "my_cluster" {
  name     = "cluster"
  location = "asia-east2"
}

provider "kubernetes" {
  host  = "https://${data.google_container_cluster.my_cluster.endpoint}"
  token = data.google_client_config.provider.access_token
  cluster_ca_certificate = base64decode(
    data.google_container_cluster.my_cluster.master_auth[0].cluster_ca_certificate,
  )
}
