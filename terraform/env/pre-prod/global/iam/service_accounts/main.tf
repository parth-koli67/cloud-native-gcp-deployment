/******************************************
  Module for service_account_gke
 *****************************************/
module "custom_role_gke" {
  source      = "../../../../modules/iam/custom-role"
  project     = var.project_id
  role_id     = var.service_account_gke["role_name"]
  permissions = var.service_account_gke["permissions"]
}
module "service_account_gke" {
  source               = "../../../../modules/iam/service-account-new"
  project_id           = var.project_id
  service_account_name = var.service_account_gke["service_account"]
}
module "member_roles_gke" {
  source                  = "../../../../modules/iam/member-iam"
  service_account_address = module.service_account_gke.email
  project                 = var.project_id
  project_roles           = ["projects/${var.project_id}/roles/${var.service_account_gke["role_name"]}", "roles/storage.objectViewer", "roles/secretmanager.secretAccessor", "roles/container.admin", "roles/monitoring.metricWriter", "roles/logging.logWriter"]
}

/******************************************
  Module for service_account_mgmt_gce
 *****************************************/
module "custom_role_mgmt_gce" {
  source      = "../../../../modules/iam/custom-role"
  project     = var.project_id
  role_id     = var.service_account_mgmt_gce["role_name"]
  permissions = var.service_account_mgmt_gce["permissions"]
}
module "service_account_mgmt_gce" {
  source               = "../../../../modules/iam/service-account-new"
  project_id           = var.project_id
  service_account_name = var.service_account_mgmt_gce["service_account"]
}
module "member_roles_mgmt_gce" {
  source                  = "../../../../modules/iam/member-iam"
  service_account_address = module.service_account_mgmt_gce.email
  project                 = var.project_id
  project_roles           = ["projects/${var.project_id}/roles/${var.service_account_mgmt_gce["role_name"]}", "roles/artifactregistry.admin", "roles/compute.admin", "roles/compute.instanceAdmin.v1", "roles/compute.networkAdmin", "roles/secretmanager.secretAccessor", "roles/iam.serviceAccountUser", "roles/storage.admin", "roles/container.admin"]
}

/******************************************
  Module for creating Github_action Service Account
 *****************************************/
module "service_account_github_acitons_sa" {
  source               = "../../../../modules/iam/service-account-new"
  project_id           = var.project_id
  service_account_name = var.service_account_github_acitons_sa["service_account"]
}
module "member_roles_github_actions_sa" {
  source                  = "../../../../modules/iam/member-iam"
  service_account_address = module.service_account_github_acitons_sa.email
  project                 = var.project_id
  project_roles           = [ "roles/artifactregistry.writer", "roles/storage.objectViewer" ]
}


