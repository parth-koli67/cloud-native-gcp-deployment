variable "project_id" {}
variable "node_pool_name" {}
variable "region" {}
variable "zones" {
  type        = list(string)
  description = "The zones to host the cluster in (optional if regional cluster / required if zonal)"
  default     = []
}
variable "gke_cluster_name" {}

variable "gke_cluster_min_master_version" {
  default = "1.16.8-gke.15"
}

variable "regional" {
  default = "false"
}
variable "auto_repair" {
  default = "true"
}
variable "metadata" {
  type = map(string)
  default = {} 
}
variable "auto_upgrade" {
  default = "false"
}
variable "enable_autoscaling" {
  default = "false"
}
variable "max_pods_per_node" {
  default = "100"
}

variable "node_count" {
  default = "1"
}
variable "initial_node_count" {
  default = "1"
}

variable "min_node_count" {
  default = "1"
}
variable "max_node_count" {
  default = "3"
}
variable "max_surge" {
  default = "1"
}
variable "max_unavailable" {
  default = "0"
}
variable "image_type" {
  default = "COS"
}

variable "machine_type" {
  default = "n1-standard-1"
}
variable "local_ssd_count" {
  default = "0"
}

variable "disk_size_gb" {
  default = "100"
}

variable "disk_type" {
  default = "pd-standard"
}

variable "preemptible" {
  default = "false"
}

variable "enable_secure_boot" {
  default = "false"
}

variable "enable_integrity_monitoring" {
  default = "true"
}

variable "labels" {
  type = map(string)
  default = {}
}

variable "service_account" {
  default = ""
}

variable "network_tags" {
  type = list(string)
  default = []
}

# variable "network_tags" {
#   type = map(list(string))
#   default = {
#     all = []
#   }
# }

variable "create_pod_range" {
  type    = bool
  default = false
}
variable "nodepool_pod_range" {
  type = string
  default = ""
}
variable "enable_private_nodes" {
  type = bool
  default = true
}
variable "pod_ipv4_cidr_block" {
  type = string
  default = ""
}

variable "workload_node_metadata_mode" {
  type = string
  description = "How to expose the node metadata to the workload running on the node. Accepted values are `UNSPECIFIED` `GKE_METADATA_SERVER` `SECURE` `EXPOSE`"
  default = null #disabled

}
variable "taint" {
  type = map(object({
    key = string
    value = string
    effect  = string
  }))
  default = {}
}

