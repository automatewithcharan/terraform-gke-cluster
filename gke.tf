resource "google_container_cluster" "primary" {
  name     = "infra-demo-gke"
  location = var.region
  project  = var.project_id

  network    = google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.gke_subnet.name
  deletion_protection = false
  remove_default_node_pool = true
  initial_node_count       = 1

  # ✅ VPC-native is already implied via ip_allocation_policy (good)
  ip_allocation_policy {
    cluster_secondary_range_name  = google_compute_subnetwork.gke_subnet.secondary_ip_range[0].range_name
    services_secondary_range_name = google_compute_subnetwork.gke_subnet.secondary_ip_range[1].range_name
  }

  # ✅ Dataplane V2
  datapath_provider = "ADVANCED_DATAPATH"

  # ✅ Turn on NetworkPolicy (DPv2 handles enforcement under the hood)
 # network_policy {
  #  enabled  = true
  #  provider = "PROVIDER_UNSPECIFIED"
 # }

  # (Optional but recommended if you’ll use GSA↔KSA later)
   workload_identity_config {
     workload_pool = "${var.project_id}.svc.id.goog"
   }

  # (Optional: keep versions stable)
  release_channel {
    channel = "REGULAR"
  }
  #NEG
  addons_config {
  http_load_balancing {
    disabled = false
  }
}
}


resource "google_container_node_pool" "default" {
  name       = "np-default"
  project    = var.project_id
  cluster    = google_container_cluster.primary.name
  location   = var.region

  node_count = 2

  node_config {
    machine_type  = "e2-standard-2"
    service_account = "default" # or your node SA email if you created one
    oauth_scopes  = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  autoscaling {
    min_node_count = 1
    max_node_count = 3
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }
}

