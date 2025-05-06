# /******************************************
# 	GCS Bucket configuration for Terraform State management
#  *****************************************/

terraform {
  backend "gcs" {
    bucket = "parth-app-tfstate-bucket"
    prefix = "gcp-deployment/terraform/env/pre-prod/global/networking/cloud_armor/"
  }
}