resource "google_compute_network" "vpc" {
  name                    = "weave-vpc"
  auto_create_subnetworks = false
  description             = "Custom VPC for GKE cluster"
}

resource "google_compute_subnetwork" "gke_subnet" {
  name          = "weave-gke-subnet"
  ip_cidr_range = "10.10.0.0/16"
  region        = var.region
  network       = google_compute_network.vpc.id

  secondary_ip_range {
    range_name    = "pods"
    ip_cidr_range = "10.20.0.0/16"
  }

  secondary_ip_range {
    range_name    = "services"
    ip_cidr_range = "10.30.0.0/16"
  }
}

