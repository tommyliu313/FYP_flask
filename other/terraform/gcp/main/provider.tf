provider "google" {
    credentials = file("itp4121project-da9e77c5e6ab.json")
    project     = "itp4121project"
    region      = "asia-east2"
    zone        = "asia-east2-a"

}

resource "google_compute_instance" "default" {
  name         = "test"
  machine_type = "e2-micro"
  region      = "asia-east2"
  zone        = "asia-east2-a"

  tags = ["foo", "bar"]

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
    foo = "bar"
  }

  metadata_startup_script = "echo hi > /test.txt"

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = "kiko00012016@gmail.com"
    scopes = ["cloud-platform"]
  }
}

resource "google_compute_instance" "default" {
  name         = "test2"
  machine_type = "e2-micro"
  region      = "asia-east2"
  zone        = "asia-east2-a"

  tags = ["foo", "bar"]

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
    foo = "bar"
  }

  metadata_startup_script = "echo hi > /test.txt"

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = "kiko00012016@gmail.com"
    scopes = ["cloud-platform"]
  }
}

resource "google_compute_disk" "default" {
  name  = "disk1"
  type  = "pd-ssd"
  zone  = "asia-east2-a"
  image = "debian-9-stretch-v20200805"
  labels = {
    environment = "dev"
  }
  physical_block_size_bytes = 4096
}

resource "google_compute_disk" "default" {
  name  = "disk2"
  type  = "pd-ssd"
  zone  = "asia-east2-a"
  image = "debian-9-stretch-v20200805"
  labels = {
    environment = "dev"
  }
  physical_block_size_bytes = 4096
}

resource "google_sql_database" "database" {
  name     = "my-database"
  instance = google_sql_database_instance.instance.name
}

# See versions at https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database_instance#database_version
resource "google_sql_database_instance" "instance" {
  name             = "my-database-instance"
  region           = "us-central1"
  database_version = "MYSQL_5_7"
  settings {
    tier = "db-f1-micro"
  }

  deletion_protection  = "true"
}
