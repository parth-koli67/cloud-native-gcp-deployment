module "upland-pre-prod-security-policy" {
  source                               = "../../../../modules/networking/cloud_armor"
  project                              = var.project
  name                                 = var.name
  ip_ranges_rules                      = var.ip_ranges_rules
  owasp_rules                          = var.owasp_rules
  rate_rules                           = var.rate_rules
  layer_7_ddos_defense_enable          = true
  layer_7_ddos_defense_rule_visibility = "STANDARD"
}
