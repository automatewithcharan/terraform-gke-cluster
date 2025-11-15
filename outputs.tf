output "vpc_name" {
  description = "The name of the created VPC"
  value       = google_compute_network.vpc.name
}

output "subnet_name" {
  description = "The name of the created subnet"
  value       = google_compute_subnetwork.gke_subnet.name
}

output "pods_secondary_range" {
  description = "The secondary range name for Pods"
  value       = google_compute_subnetwork.gke_subnet.secondary_ip_range[0].range_name
}

output "services_secondary_range" {
  description = "The secondary range name for Services"
  value       = google_compute_subnetwork.gke_subnet.secondary_ip_range[1].range_name
}

