module "gcloud" {
  source  = "terraform-google-modules/gcloud/google"
  version = "~> 2.0"

  platform = "linux"
  additional_components = ["kubectl", "beta"]

  create_cmd_entrypoint  = "gcloud"
  create_cmd_body        = "version"
  destroy_cmd_entrypoint = "gcloud"
  destroy_cmd_body       = "version"
}

module "cloud-nat" {
  source     = "terraform-google-modules/cloud-nat/google"
  version    = "~> 1.2"
  project_id = itp4121project
  region     = asia-east2
  router     = google_compute_router.router.name
}

module "load_balancer" {
  source       = "GoogleCloudPlatform/lb/google"
  version      = "~> 2.0.0"
  region       = asia-east2
  name         = "load-balancer"
  service_port = 80
  target_tags  = ["allow-lb-service"]
  network      = var.network
}

#kubernetes
module "gke" {
  source                     = "terraform-google-modules/kubernetes-engine/google"
  project_id                 = itp4121project
  name                       = "gke-test-project"
  region                     = "asia-east2"
  zones                      = ["asia-east2-a", "asia-east2-b", "asia-east2-c"]
  network                    = "vpc-01"
  subnetwork                 = "asia-east2-01"
  ip_range_pods              = "asia-east2-01-gke-01-pods"
  ip_range_services          = "asia-east2-01-gke-01-services"
  http_load_balancing        = false
  network_policy             = false
  horizontal_pod_autoscaling = true
  filestore_csi_driver       = false

  node_pools = [
    {
      name                      = "default-node-pool"
      machine_type              = "f1-micro"
      node_locations            = "asia-east2-b,asia-east2-c"
      min_count                 = 1
      max_count                 = 100
      local_ssd_count           = 0
      disk_size_gb              = 100
      disk_type                 = "pd-standard"
      image_type                = "COS_CONTAINERD"
      enable_gcfs               = false
      auto_repair               = true
      auto_upgrade              = true
      service_account           = "project-service-account@<PROJECT ID>.iam.gserviceaccount.com"
      preemptible               = false
      initial_node_count        = 80
    },
  ]

  node_pools_oauth_scopes = {
    all = []

    default-node-pool = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

  node_pools_labels = {
    all = {}

    default-node-pool = {
      default-node-pool = true
    }
  }

  node_pools_metadata = {
    all = {}

    default-node-pool = {
      node-pool-metadata-custom-value = "my-node-pool"
    }
  }

  node_pools_taints = {
    all = []

    default-node-pool = [
      {
        key    = "default-node-pool"
        value  = true
        effect = "PREFER_NO_SCHEDULE"
      },
    ]
  }

  node_pools_tags = {
    all = []

    default-node-pool = [
      "default-node-pool",
    ]
  }
}

#load balancer
module "gce-lb-http" {
  source            = "GoogleCloudPlatform/lb-http/google"
  version           = "~> 4.4"

  project           = "my-project-id"
  name              = "group-http-lb"
  target_tags       = [module.mig1.target_tags, module.mig2.target_tags]
  backends = {
    default = {
      description                     = null
      protocol                        = "HTTP"
      port                            = var.service_port
      port_name                       = var.service_port_name
      timeout_sec                     = 10
      enable_cdn                      = false
      custom_request_headers          = null
      custom_response_headers         = null
      security_policy                 = null

      connection_draining_timeout_sec = null
      session_affinity                = null
      affinity_cookie_ttl_sec         = null

      health_check = {
        check_interval_sec  = null
        timeout_sec         = null
        healthy_threshold   = null
        unhealthy_threshold = null
        request_path        = "/"
        port                = var.service_port
        host                = null
        logging             = null
      }

      log_config = {
        enable = true
        sample_rate = 1.0
      }

      groups = [
        {
          # Each node pool instance group should be added to the backend.
          group                        = var.backend
          balancing_mode               = null
          capacity_scaler              = null
          description                  = null
          max_connections              = null
          max_connections_per_instance = null
          max_connections_per_endpoint = null
          max_rate                     = null
          max_rate_per_instance        = null
          max_rate_per_endpoint        = null
          max_utilization              = null
        },
      ]

      iap_config = {
        enable               = false
        oauth2_client_id     = null
        oauth2_client_secret = null
      }
    }
  }
}

module "gce-ilb-http"{
  source = "github.com/GoogleCloudPlatform/terraform-google-lb-http"
  name = "group-http-lb"
  target_tags = ["${module.mig1.target_tags}","${module.mig2.target_tags}"]
  backends = {
  "0"=[
    {group = "${module.mig2.instance_group}"},
    {group = "${module.mig3.instance_group}"}],
  }
  backend_params = [
  # health check path, port name, port number, timeout seconds.
    "/,http,80,10"
  ]
}

module "load_balancer" {
  source       = "GoogleCloudPlatform/lb/google"
  version      = "~> 2.0.0"
  region       = var.region
  name         = "load-balancer"
  service_port = 80
  target_tags  = ["allow-lb-service"]
  network      = var.network
}

# s3
module "cloud-storage" {
  source  = "terraform-google-modules/cloud-storage/google"
  version = "3.2.0"
  # insert the 1 required variable here
}

#
module "appengine" {
  source  = "JamesWoolfenden/appengine/gcp"
  version = "0.1.19"
  # insert the 4 required variables here
}

#sql
module "sql-db" {
  source  = "GoogleCloudPlatform/sql-db/google"
  version = "10.0.1"
}
