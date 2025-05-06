/******************************************
  service_account variables
 *****************************************/

variable "project_id" {
  description = "The GCP project ID"
}

variable "region" {
  description = "The GCP region of the deployment."
}

variable "service_account_gke" {
  description = "service Account to add the IAM policies/bindings for gke"
}

variable "service_account_mgmt_gce" {
  description = "service Account to add the IAM policies/bindings for vm"
}

variable "service_account_github_acitons_sa" {
  description = "service Account to add the IAM policies/bindings for TF"
}


