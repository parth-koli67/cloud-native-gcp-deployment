/******************************************
  Providers Variables
 *****************************************/

variable "project_id" {
  description = "Existing Base project"
  type        = string
}

variable "terraform_owner_email" {
  description = "Email of the service account that will be used to create the project."
  type        = string
}



/******************************************
  service_account variables
 /*****************************************/

variable "service_account_terraform" {
  description = "Terraform Resource Deployment Service Account to add the IAM policies/bindings"
}


/******************************************
        Service API variables
 *****************************************/

variable "project_services_api" {
  type = map(
    object(
      {
        project_id                 = string
        activate_apis              = list(string)
        disable_dependent_services = bool
        disable_services_on_destroy = bool
      }
    )
  )
  default = {}
}



/*******************
  IAM Binding
 *******************/
variable "iam_bindings_config" {
  default = {}
}





/******************************************
  service_account variables
 *****************************************/


variable "region" {
  description = "The GCP region of the deployment."
}

variable "service_account_gke" {
  description = "service Account to add the IAM policies/bindings for gke"
}

variable "service_account_mgmt_gce" {
  description = "service Account to add the IAM policies/bindings for vm"
}

# variable "service_account_tf_sa" {
#   description = "service Account to add the IAM policies/bindings for vm"
# }

/******************************************
	VPC Subnet details
 *****************************************/
/******************************************
	VPC Subnet creation variables
 *****************************************/

variable "vpc_config" {
  description = "The details of the Cloud Storage Buckets."
  type = map(object({
    project_id              = optional(string)
    network_name            = string
    routing_mode            = optional(string)
    description             = optional(string)
    shared_vpc_host         = bool
    auto_create_subnetworks = bool
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

/******************************************
  Firewall Rule creation variables
 *****************************************/

variable "vpc_name" {
  description = "The name of the network for which Firewall rules will be created"
}

# variable "shared_vpc_host" {
#   type        = bool
#   description = "Makes this project a Shared VPC host if 'true' (default 'false')"
# }

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

/******************************************
	NAT gateway creation variables
 *****************************************/

variable "nat_name" {
  description = "The name of the network for which NAT gateway will be created"
}
variable "router_name" {
  description = "The name of the network for which NAT gateway will be created"
}
variable "address_name" {
  description = "The name of the network for which NAT gateway will be created"
}


variable "compute_instance" {
  description = "The details of the Compute Instance."
  type = map(object({
    machine_name            = string,
    project_id              = string,
    region                  = string,
    enable_external_ip      = bool,
    generate_internal_ip    = bool,
    internal_ip_address     = list(string),
    vm_description          = string,
    instance_count          = number,
    network                 = string,
    subnetwork              = string,
    machine_zone            = list(string),
    vm_deletion_protect     = bool,
    instance_image_selflink = string,
    machine_type            = string,
    instance_labels         = map(string),
    network_tags            = list(string),
    service_account = object({
      email  = string,
      scopes = set(string)
    })
    boot_disk0_info = object({
      disk_size_gb = number,
      disk_type    = string
    })
  }))
  default = {
    compute_insatnce = {
      machine_name            = ""
      project_id              = ""
      region                  = "us-central1"
      enable_external_ip      = false
      generate_internal_ip    = true
      internal_ip_address     = [""]
      machine_zone            = []
      vm_description          = ""
      instance_count          = 1
      network                 = ""
      subnetwork              = ""
      vm_deletion_protect     = false
      instance_image_selflink = ""
      machine_type            = ""
      instance_labels         = {}
      disk_labels             = {}
      network_tags            = []
      service_account         = null
      snapshot_policy_name    = ""
      boot_disk0_info = {
        disk_size_gb = 10,
        disk_type    = "pd-balanced"
      }
      enable_data_disk = false
    }
  }
}
