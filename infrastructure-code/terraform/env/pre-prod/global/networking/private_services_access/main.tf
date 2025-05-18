/******************************************
	Module for Private Access
 *****************************************/

module "private-service-access" {
  source        = "../../../../modules/networking/private_service_access"
  for_each      = var.psa_config
  psa_name      = each.value.psa_name
  project_id    = each.value.project_id
  vpc_network   = each.value.vpc_network
  address       = each.value.vpc_address
  prefix_length = each.value.prefix_length
}
