
/******************************************
    SA Account Impersonate configuration
 *****************************************/

provider "google" {
  alias = "impersonator"
}
data "google_service_account_access_token" "impersonated" {
  provider               = google.impersonator
  target_service_account = var.terraform_owner_email
  scopes                 = ["cloud-platform"]
  lifetime               = "1800s" # 30 minutes
}

provider "google" {
  access_token = data.google_service_account_access_token.impersonated.access_token
  project      = var.project_id
}

provider "google-beta" {
  access_token = data.google_service_account_access_token.impersonated.access_token
  project      = var.project_id
}

