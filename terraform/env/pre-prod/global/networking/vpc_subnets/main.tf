/******************************************
	VPC configuration
 *****************************************/
module "vpc" {
  source                  = "../../../../modules/networking/vpc"
  for_each                = var.vpc_config
  project_id              = var.project_id
  network_name            = each.value.network_name
  routing_mode            = each.value.routing_mode
  description             = each.value.description
  shared_vpc_host         = each.value.shared_vpc_host
  auto_create_subnetworks = each.value.auto_create_subnetworks
}

# Capture the name of the first VPC
locals {
  first_vpc_name = values(module.vpc)[0].network_name
}

/******************************************
	Subnet configuration
 *****************************************/
module "subnets" {
  source           = "../../../../modules/networking/subnets"
  project_id       = var.project_id
  network_name     = local.first_vpc_name
  subnets          = var.subnets
  secondary_ranges = var.secondary_ranges
}
