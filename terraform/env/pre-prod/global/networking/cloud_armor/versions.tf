terraform {
  required_version = ">= 1.3.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.79, < 7"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = ">= 4.79, < 7"
    }
  }
  provider_meta "google" {
    module_name = "blueprints/terraform/terraform-google-cloud-armor/v3.0.0"
  }
  provider_meta "google-beta" {
    module_name = "blueprints/terraform/terraform-google-cloud-armor/v3.0.0"
  }
}