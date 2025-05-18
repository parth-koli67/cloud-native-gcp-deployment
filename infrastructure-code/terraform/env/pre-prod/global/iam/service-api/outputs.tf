/******************************************
         Outputs of  Dev Project
 *****************************************/
output "custom_role_terraform" {
  value       = module.custom_role_terraform
  description = "The details of the Custom Role attached with Terraform Service Account"
}

output "member_roles_terraform" {
  value       = module.member_roles_terraform
  description = "The details of the Terraform Service Account with which the Customer Role has been bound"
}

output "project_services_api_details" {
  value       = module.project_services_api
  description = "The details of the APIs enabled in Project"
}



