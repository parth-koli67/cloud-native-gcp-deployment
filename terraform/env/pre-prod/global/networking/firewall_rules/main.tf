/******************************************
  Module for IAP tunneling access for all VMs
 *****************************************/

module "fw_rules" {
  source = "../../../../modules/networking/firewall"

  for_each = { for rule in var.firewall_rules : rule.name => rule }

  network       = var.vpc_name
  name          = each.value.name
  protocol      = each.value.protocol
  ports         = each.value.ports
  source_ranges = each.value.source_ranges
  source_tags   = each.value.source_tags
  target_tags   = each.value.target_tags
}
