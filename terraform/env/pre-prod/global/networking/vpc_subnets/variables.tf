/******************************************
	VPC Subnet creation variables
 *****************************************/

variable "project_id" {
  description = "The ID of the project where this VPC will be created"
}

variable "region" {
  description = "The Region to deploy all resources"
}

variable "vpc_config" {
  description = "The details of the Cloud Storage Buckets."
  type = map(object({
    project_id              = optional(string),
    network_name            = string,
    routing_mode            = optional(string),
    description             = optional(string),
    shared_vpc_host         = bool,
    auto_create_subnetworks = bool,
  }))
}

variable "subnets" {
  type        = list(map(string))
  description = "The list of subnets being created"
}

variable "secondary_ranges" {
  type        = map(list(object({ range_name = string, ip_cidr_range = string })))
  description = "Secondary ranges that will be used in some of the subnets"
}

variable "routing_mode" {
  type        = string
  default     = "GLOBAL"
  description = "The network routing mode (default 'GLOBAL')"
}

variable "description" {
  type        = string
  description = "An optional description of this resource. The resource must be recreated to modify this field."
  default     = "This VPC network will be used for dev Project"
}
