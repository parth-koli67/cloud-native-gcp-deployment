/******************************************
  Firewall Rule creation variables
 *****************************************/

variable "project_id" {
  description = "Project ID to reserve static IPs"
}
variable "region" {
  description = "Region to reserve static IPs"
}
variable "vpc_name" {
  description = "The name of the network for which Firewall rules will be created"
}

variable "firewall_rules" {
  description = "A list of firewall rule configurations."
  type = list(object({
    network       = string
    name          = string
    protocol      = string
    ports         = list(string)
    source_ranges = list(string)
    source_tags   = list(string)
    target_tags   = list(string)
  }))
}
