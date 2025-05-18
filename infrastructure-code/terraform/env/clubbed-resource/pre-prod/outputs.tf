/******************************************
         Outputs of  Dev Project
 *****************************************/
output "custom_role_terraform" {
  value       = module.custom_role_terraform
  description = "The details of the Custom Role attached with Terraform Service Account"
}

# output "member_roles_terraform" {
#   value       = module.member_roles_terraform
#   description = "The details of the Terraform Service Account with which the Customer Role has been bound"
# }

output "project_services_api_details" {
  value       = module.project_services_api
  description = "The details of the APIs enabled in Project"
}



/******************************************
  Outputs of service_account and role bindings
 *****************************************/
output "custom_role_gke" {
  value = module.custom_role_gke.role_name
}
output "service_account_gke_email" {
  value = module.service_account_gke.email
}


###########################vpc subnet#####################


output "network_name" {
  value       = module.vpc
  description = "The name of the VPC being created"
}

output "subnets_names" {
  value       = [for network in module.subnets.subnets : network.name]
  description = "The names of the subnets being created"
}

output "subnets_ips" {
  value       = [for network in module.subnets.subnets : network.ip_cidr_range]
  description = "The IPs and CIDRs of the subnets being created"
}

output "subnets_regions" {
  value       = [for network in module.subnets.subnets : network.region]
  description = "The region where the subnets will be created"
}

/******************************************
  Firewall Rule details
 *****************************************/

output "fw_rules" {
  value = module.fw_rules
}


/******************************************
	NAT gateway details
 *****************************************/

output "cloud_nat_name" {
  description = "Name of the Cloud NAT"
  value       = module.cloud-nat.name
}

output "compute_instance" {
  description = "The Details of Compute Instance created."
  value       = module.compute_instance
}

