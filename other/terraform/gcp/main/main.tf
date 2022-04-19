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

module "vpc" {
  source = "terraform-google-modules/network/google"
  version = "2.5.0"

  project_id = "itp4121project"
  network_name = "vpc"
  routing_mode = "REGIONAL"

  delete_default_internet_gateway_routes = "true"

  subnets = [
    {
      subnet_name           = "public"
      subnet_ip             = "10.0.0.0/24"
      subnet_region         = "asia-east2"
      subnet_private_access = "false"
      subnet_flow_logs      = "false"
    },

    {
      subnet_name           = "private"
      subnet_ip             = "10.0.1.0/24"
      subnet_region         = "asia-east2"
      subnet_private_access = "true"
      subnet_flow_logs      = "false"
    }
  ]

  routes = [
    {
      name              = "egress-internet"
      description       = "Default route through IGW to access internet"
      destination_range = "0.0.0.0/0"
      next_hop_internet = "true"
    }
  ]
}
    
resource "google_compute_instance_template" "default" {
  provider = google

  name           = "instance-projecte"
  machine_type   = "f1-micro"
  can_ip_forward = false

  tags = ["foo", "bar"]

  disk {
    source_image = data.google_compute_image.debian_9.id
  }

  network_interface {
    network = "default"
  }

  metadata = {
    foo = "bar"
  }

  service_account {
    scopes = ["itp4121project"]
  }
}
    
resource "google_compute_instance_group" "test" {
  name        = "instance-group-project"
  description = "Terraform test instance group"
  region      = "asia-east2"
  zone        = "asia-east2-a"
  network     = google_compute_network.default.id
  Autoscaling_mode = "On: add and remove instances to the group"
  Minimum = 1
  Maximum = 10
}    


module "cloud_router" {
  source  = "terraform-google-modules/cloud-router/google"
  version = "0.3.0"

  name    = "router"
  project = local.project
  region  = local.region
  network = module.vpc.network_name
  nats = [{
    name                               = "nat"
    nat_ip_allocate_option             = "AUTO_ONLY"
    source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
    subnetworks = [{
      name                    = "private"
      source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
    }]
  }]
}
