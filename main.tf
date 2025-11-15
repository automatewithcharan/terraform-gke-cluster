terraform {
  required_providers {
	google = {
		source = "hashicorp/google"
		version = "~>5.0"
   }
}
required_version = ">= 1.3.0"

backend "gcs" {
    bucket = "nbss-tf-state"
    prefix = "terraform-gke/dev"  # folder-like path inside the bucket
  }
}

provider "google" {
 credentials = file("terraform-sa-key.json")
 project = var.project_id
 region = var.region
}


