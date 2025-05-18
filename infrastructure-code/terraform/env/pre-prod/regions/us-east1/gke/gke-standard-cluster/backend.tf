
# --------------------------------------------------------
# GCS Bucket configuration for Terraform State management
# -------------------------------------------------------- 

terraform {
  backend "gcs" {
    bucket = "parth-app-tfstate-bucket"
    prefix = "gcp-deployment/terraform/env/pre-prod/regions/us-central1/gke/standard/"
  }
}
