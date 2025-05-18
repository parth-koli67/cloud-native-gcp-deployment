variable "project_id" {
  description = "The ID of the project where this VPC will be created"
  type        = string
}

variable "network_name" {
  description = "The name of the network being created"
  type        = string
}

variable "region" {
  description = "GCP region where the resource will be created"
  type        = string
}

variable "name" {
  description = "name used to generate the LB."
  type        = string
}

variable "port_specification" {
  description = "Port specification for tcp health check can be - USE_FIXED_PORT, USE_NAMED_PORT, USE_SERVING_PORT"
  type        = string
  default     = "USE_SERVING_PORT"
}

variable "managed_ssl_certificate_domains" {
  description = "Create Google-managed SSL certificates for specified domains. Requires `ssl` to be set to `true` and `use_ssl_certificates` set to `false`."
  type        = list(string)
  default     = []
}

variable "backend_services" {
  description = "list of Backend services for the LB."
}

variable "certificate_map" {
  description = "GCP Managed certificate name"
}
variable "global_static_ip" {
  description = "Name of global static IP created."
}

variable "neg_name" {
  description = "name of the neg to be created"
}

variable "https_redirect_name" {
  description = "name of the https_redirect to be created"
}