variable "project_id" {
  description = "The ID of the GCP project to deploy resources into"
  type        = string
}

variable "region" {
  description = "The region to deploy resources"
  type        = string
  default     = "europe-west3"
}

variable "primary_cidr" {
  description = "Primary subnet range for GKE nodes"
  type        = string
  default     = "10.10.0.0/16"
}

variable "pods_cidr" {
  description = "Secondary range for GKE pods"
  type        = string
  default     = "10.20.0.0/16"
}

variable "services_cidr" {
  description = "Secondary range for GKE services"
  type        = string
  default     = "10.30.0.0/16"
}

