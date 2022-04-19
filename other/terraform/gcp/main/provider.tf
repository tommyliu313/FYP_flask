provider "google" {
    credentials = file("itp4121project-da9e77c5e6ab.json")
    project     = "itp4121project"
    region      = "asia-east2"
    zone        = "asia-east2-a"

}

resource "google_compute_instance" "default" {
  name         = "test"
  machine_type = "e2-medium"
  zone         = "asis-east2-a"

  tags = ["v", "m"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  // Local SSD disk
  scratch_disk {
    interface = "SCSI"
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }

  metadata = {
    v = "m"
  }

  metadata_startup_script = "echo hi > /test.txt"

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = kiko2
    scopes = ["cloud-platform"]
  }
}

resource "google_sql_database" "database" {
  name     = "projectmysqltest"
  instance = google_sql_database_instance.instance.name
}

# See versions at https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database_instance#database_version
resource "google_sql_database_instance" "projectmysqltest" {
  name             = "projectmysqltest"
  region           = "asia-east2"
  database_version = "MYSQL_5_7"
  settings {
    tier = "db-f1-micro"
  }

  deletion_protection  = "true"
}

provider "kubernetes"{
  version = "~> 1.10.0"
  host = google_container_cluster.default.endpoint
  token = data.google_client_config.current.access_token
  client_certificate = base64encode(google_container_cluster.default.master_auth[0].client_certificate,)
  client_key = base64decode(google_container_cluster.default.master_auth[0].client_key)
  cluster_ca_certificate = base64decode(google_container_cluster.default.master_auth[0].cluster_ca_certificate,)
}
