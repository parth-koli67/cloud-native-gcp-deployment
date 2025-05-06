# /******************************************************************
#         Terraform Custom Role and SA IAM Binding Module 
#  ******************************************************************/

#Custom Roles Module
module "custom_role_terraform" {
  source      = "../../modules/iam/custom-role"
  project     = var.project_id
  role_id     = var.service_account_terraform["role_name"]
  permissions = var.service_account_terraform["permissions"]
}

# IAM Binding of Custom Roles Module
module "member_roles_terraform" {
  source                  = "../../modules/iam/member-iam"
  service_account_address = var.terraform_owner_email
  project                 = var.project_id
  project_roles           = ["projects/${var.project_id}/roles/${var.service_account_terraform["role_name"]}"]
  depends_on              = [module.custom_role_terraform]
}

// iam.googleapis.com needs to enabled manually
// cloudresourcemanager.googleapis.com
#Service API Module
module "project_services_api" {
  source                     = "../../modules/service-api"
  for_each                   = var.project_services_api
  disable_dependent_services = each.value.disable_dependent_services
  project_id                 = each.value.project_id
  activate_apis              = each.value.activate_apis
  depends_on                 = [module.custom_role_terraform, module.member_roles_terraform]
  # depends_on                 = [module.custom_role_terraform]

}

/******************************************
  Module for service_account_gke
 *****************************************/
module "custom_role_gke" {
  source      = "../../modules/iam/custom-role"
  project     = var.project_id
  role_id     = var.service_account_gke["role_name"]
  permissions = var.service_account_gke["permissions"]
  depends_on = [module.project_services_api]
}


module "service_account_gke" {
  source               = "../../modules/iam/service-account-new"
  project_id           = var.project_id
  service_account_name = var.service_account_gke["service_account"]
  depends_on = [module.custom_role_gke]
}



/******************************************
  Module for service_account_mgmt_gce
 *****************************************/
module "custom_role_mgmt_gce" {
  source      = "../../modules/iam/custom-role"
  project     = var.project_id
  role_id     = var.service_account_mgmt_gce["role_name"]
  permissions = var.service_account_mgmt_gce["permissions"]
  depends_on = [module.project_services_api]
}
module "service_account_mgmt_gce" {
  source               = "../../modules/iam/service-account-new"
  project_id           = var.project_id
  service_account_name = var.service_account_mgmt_gce["service_account"]
  depends_on = [module.custom_role_mgmt_gce]
}


/******************************************
	VPC configuration
 *****************************************/
module "vpc" {
  source                  = "../../modules/networking/vpc"
  for_each                = var.vpc_config
  project_id              = var.project_id
  network_name            = each.value.network_name
  routing_mode            = each.value.routing_mode
  description             = each.value.description
  shared_vpc_host         = each.value.shared_vpc_host
  auto_create_subnetworks = each.value.auto_create_subnetworks
  depends_on = [module.custom_role_terraform]
}

# Capture the name of the first VPC
locals {
  first_vpc_name = values(module.vpc)[0].network_name
}

/******************************************
	Subnet configuration
 *****************************************/
module "subnets" {
  source           = "../../modules/networking/subnets"
  project_id       = var.project_id
  network_name     = local.first_vpc_name
  subnets          = var.subnets
  secondary_ranges = var.secondary_ranges
  depends_on = [module.vpc]
}

/******************************************
  Module for IAP tunneling access for all VMs
 *****************************************/

module "fw_rules" {
  source = "../../modules/networking/firewall"

  for_each = { for rule in var.firewall_rules : rule.name => rule }

  network       = var.vpc_name
  name          = each.value.name
  protocol      = each.value.protocol
  ports         = each.value.ports
  source_ranges = each.value.source_ranges
  source_tags   = each.value.source_tags
  target_tags   = each.value.target_tags
  depends_on = [module.vpc]
}


/******************************************
  Resource for External Static IPs
 *****************************************/

resource "google_compute_address" "address" {
  count  = 2
  name   = "${var.address_name}-0${count.index + 1}"
  region = var.region
}

# /******************************************
#   Resource for Cloud Router for NAT GW
#  *****************************************/

resource "google_compute_router" "router" {
  name    = var.router_name
  region  = var.region
  network = var.vpc_name
  depends_on = [module.vpc]
}


/******************************************
  Module for NAT Gateway
 *****************************************/

module "cloud-nat" {
  source                             = "../../modules/networking/nat_gateway"
  project_id                         = var.project_id
  region                             = var.region
  router                             = google_compute_router.router.name
  name                               = var.nat_name
  nat_ips                            = google_compute_address.address.*.self_link
  min_ports_per_vm                   = "128"
  icmp_idle_timeout_sec              = "15"
  tcp_established_idle_timeout_sec   = "600"
  tcp_transitory_idle_timeout_sec    = "15"
  udp_idle_timeout_sec               = "15"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  # address_name                       = var.address_name
  depends_on = [
    google_compute_router.router,
    google_compute_address.address
  ]
}

/******************************************
  Details of Compute Engine
 *****************************************/

module "compute_instance" {
  source                  = "../../modules/compute-engine/linux-vm"
  for_each                = var.compute_instance
  project                 = each.value.project_id
  region                  = each.value.region
  instance_count          = each.value.instance_count
  machine_name            = each.value.machine_name
  vm_description          = each.value.vm_description
  enable_external_ip      = each.value.enable_external_ip
  generate_internal_ip    = each.value.generate_internal_ip
  internal_ip_address     = each.value.internal_ip_address
  machine_type            = each.value.machine_type
  zone                    = each.value.machine_zone
  instance_labels         = each.value.instance_labels
  vm_deletion_protect     = each.value.vm_deletion_protect
  instance_image_selflink = each.value.instance_image_selflink
  network                 = each.value.network
  subnetwork              = each.value.subnetwork
  network_tags            = each.value.network_tags
  boot_disk_info          = each.value.boot_disk0_info
  service_account         = each.value.service_account
  depends_on              = [module.subnets]
}
