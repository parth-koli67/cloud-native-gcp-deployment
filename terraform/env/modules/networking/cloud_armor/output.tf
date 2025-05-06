output "id" {
  value = google_compute_security_policy.policy.id
}

output "ip_ranges_rules" {
  value = var.ip_ranges_rules
}