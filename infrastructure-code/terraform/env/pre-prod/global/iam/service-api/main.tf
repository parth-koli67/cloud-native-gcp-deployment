# /******************************************************************
#         Terraform Custom Role and SA IAM Binding Module 
#  ******************************************************************/

#Custom Roles Module
module "custom_role_terraform" {
  source      = "../../../../modules/iam/custom-role"
  project     = var.project_id
  role_id     = var.service_account_terraform["role_name"]
  permissions = var.service_account_terraform["permissions"]
}

#IAM Binding of Custom Roles Module
module "member_roles_terraform" {
  source                  = "../../../../modules/iam/member-iam"
  service_account_address = var.terraform_owner_email
  project                 = var.project_id
  project_roles           = ["projects/${var.project_id}/roles/${var.service_account_terraform["role_name"]}", "roles/compute.networkAdmin", "roles/cloudsql.admin", "roles/compute.loadBalancerAdmin", "roles/compute.orgSecurityPolicyAdmin"]
  depends_on              = [module.custom_role_terraform]
}

// iam.googleapis.com needs to enabled manually
// cloudresourcemanager.googleapis.com
#Service API Module
module "project_services_api" {
  source                     = "../../../../modules/service-api"
  for_each                   = var.project_services_api
  disable_dependent_services = each.value.disable_dependent_services
  project_id                 = each.value.project_id
  activate_apis              = each.value.activate_apis
  depends_on                 = [module.custom_role_terraform, module.member_roles_terraform]
}







