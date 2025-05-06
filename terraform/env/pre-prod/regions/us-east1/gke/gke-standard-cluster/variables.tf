/**
 * Copyright 2023 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

variable "ip_range_pods" {
  description = "ip range"
  type        = string
  default     = ""
}
variable "ip_range_services" {
  description = "ip range"
  type        = string
  default     = ""
}

variable "network_project_id" {
  type        = string
  description = "The project ID of the shared VPC's host (for shared vpc support)"
  default     = ""
}

variable "project_id" {
  description = "GCP Project ID in which the resource will be provisioned."
  type        = string
  default     = ""
}



/******************************************
   Variables for GKE Cluster
  *****************************************/

variable "app_name" {
  default = ""
  type    = string
}

variable "datapath_provider" {
  type        = string
  description = "The desired datapath provider for this cluster. By default, `DATAPATH_PROVIDER_UNSPECIFIED` enables the IPTables-based kube-proxy implementation. `ADVANCED_DATAPATH` enables Dataplane-V2 feature."
  default     = "DATAPATH_PROVIDER_UNSPECIFIED"
}

variable "enable_binary_authorization" {
  type        = bool
  description = "Enable BinAuthZ Admission controller"
  default     = true
}

variable "enable_gateway_api" {
  type        = bool
  description = "Enable Gateway API for the cluster"
  default     = false
}

variable "enable_private_endpoint" {
  type        = bool
  description = "(Beta) Whether the master's internal IP address is used as the cluster endpoint"
  default     = false
}
variable "enable_workload_identity" {
  type        = bool
  description = "Enable or disable workload_identity on GKE cluster"
  default     = false
}
variable "gke_backup_agent_config" {
  type        = bool
  description = "Whether Backup for GKE agent is enabled for this cluster."
  default     = false
}

variable "dns_cache_config" {
  type        = bool
  description = "Whether NodeLocalCache for GKE agent is enabled for this cluster."
  default     = false
}

variable "enable_cost_allocation" {
  type        = bool
  description = "Enables Cost Allocation Feature and the cluster name and namespace of your GKE workloads appear in the labels field of the billing export to BigQuery"
  default     = false
}

# variable "default_nodepool_tags" {
#   type        = list(string)
#   description = "Map of lists containing node network tags by node-pool name"

#   # Default is being set in variables_defaults.tf
#   default = []
# }

variable "enable_private_nodes" {
  type        = bool
  description = "(Beta) Whether nodes have internal IP addresses only"
  default     = false
}


variable "gke_cluster_master_version" {
  description = "GKE version"
  default     = ""
}


variable "horizontal_pod_autoscaling" {
  type        = bool
  description = "Enable horizontal pod autoscaling addon"
  default     = true
}

variable "http_load_balancing" {
  type        = bool
  description = "Enable httpload balancer addon"
  default     = true
}

variable "master_ipv4_cidr_block" {
  description = "The IP range in CIDR notation to use for the hosted master network"
  default     = "x.x.x.x/28"
}

variable "master_authorized_networks" {
  type        = list(object({ cidr_block = string, display_name = string }))
  description = "List of master authorized networks. If none are provided, disallow external access (except the cluster node IPs, which GKE automatically whitelists)."
  default     = [{ cidr_block = "10.1.1.0/24", display_name = "bastion-host" }]
}

variable "node_labels" {
  type        = map(string)
  description = "gke cluster labels"
  default     = {}
}

## Tags for the default Node Pool to provide internet connectivity
variable "node_pools_tags" {
  type        = map(list(string))
  description = "Map of lists containing node network tags by node-pool name"

  # Default is being set in variables_defaults.tf
  default = {
    all               = []
    default-node-pool = []
  }
}

variable "network" {
  description = "The value of network"
  type        = string
  default     = ""
}

variable "network_policy" {
  type        = bool
  description = "Enable network policy addon"
  default     = true
}

variable "gke_subnetwork" {
  description = "The value of subnetwork"
  type        = string
  default     = ""
}

variable "remove_default_node_pool" {
  type        = bool
  description = "Remove default node pool while setting up the cluster"
  default     = true
}

variable "release_channel" {
  type        = string
  description = "The release channel of this cluster. Accepted values are `UNSPECIFIED`, `RAPID`, `REGULAR` and `STABLE`. Defaults to `REGULAR`."
  default     = "REGULAR"
}

variable "enable_security_posture" {
  type        = bool
  description = "Enables Security posture Feature"
  default     = false
}

variable "security_posture_mode" {
  description = "Security posture mode.  Accepted values are DISABLED and BASIC. Defaults to DISABLED."
  type        = string
  default     = "DISABLED"
}

variable "security_posture_vulnerability_mode" {
  description = "Security posture vulnerability mode.  Accepted values are VULNERABILITY_DISABLED and VULNERABILITY_BASIC. Defaults to VULNERABILITY_DISABLED."
  type        = string
  default     = "VULNERABILITY_DISABLED"
}
variable "resource_usage_export_dataset_id" {
  type        = string
  description = "The ID of a BigQuery Dataset for using BigQuery as the destination of resource usage export."
  default     = ""
}
variable "workload_identity_pool" {
  type        = string
  description = "Workload Identity allows Kubernetes service accounts to act as a user-managed Google IAM Service Account. Currently, the only supported identity namespace is the project's default."
  default     = null
}
variable "maintenance" {
  type = object({
    start_time           = string
    end_time             = string
    recurrence_frequency = string
  })
  default = {
    start_time           = "2021-08-01T19:30:00Z"
    end_time             = "2021-08-01T23:30:00Z"
    recurrence_frequency = "FREQ=DAILY"
  }
}
/******************************************
   Variables for Node pools
  *****************************************/

variable "node_pools" {
  description = "The details of node pools to be attached to the GKE cluster"
  type = map(object({
    app_name                       = string
    region                         = string
    regional                       = bool
    zones                          = list(string)
    gke_cluster_min_master_version = string
    image_type                     = string
    machine_type                   = string
    preemptible                    = bool
    auto_upgrade                   = bool
    auto_repair                    = bool
    max_pods_per_node              = number
    node_count                     = number
    initial_node_count             = number
    local_ssd_count                = number
    enable_autoscaling             = bool
    min_node_count                 = number
    max_node_count                 = number
    labels                         = map(string)
    disk_size_gb                   = number
    disk_type                      = string
    max_surge                      = number
    max_unavailable                = number
    enable_secure_boot             = bool
    enable_integrity_monitoring    = bool
    service_account                = string
    network_tags                   = list(string)
    create_pod_range               = optional(bool)
    nodepool_pod_range             = optional(string)
    enable_private_nodes           = optional(bool)
    nodepool_pod_cidr_range        = optional(string)
    metadata                       = map(string)
  }))
  default = {
    node-pool = {
      app_name                       = ""
      region                         = ""
      regional                       = true
      zones                          = []
      gke_cluster_min_master_version = ""
      image_type                     = ""
      machine_type                   = ""
      preemptible                    = false
      auto_upgrade                   = true
      auto_repair                    = true
      max_pods_per_node              = 64
      node_count                     = 1
      initial_node_count             = 1
      local_ssd_count                = 0
      enable_autoscaling             = false
      min_node_count                 = 1
      max_node_count                 = 3
      labels                         = {}
      disk_size_gb                   = 100
      disk_type                      = "pd-standard"
      max_surge                      = 1
      max_unavailable                = 0
      enable_secure_boot             = false
      enable_integrity_monitoring    = true
      workload_node_metadata_mode    = null
      metadata                       = null
      network_tags                   = []
      create_pod_range               = false
      nodepool_pod_range             = ""
      enable_private_nodes           = true
      nodepool_pod_cidr_range        = ""
      service_account                = ""
    }
  }
}

variable "region" {}

variable "regional" {
  description = "Whether it is a regional cluster "
  default     = true
}

variable "service_account" {
  description = "The service account to run cluster"
  default     = ""
}

variable "zones" {
  description = "The zones to host the cluster in (optional if regional cluster / required if zonal)"
  type        = list(string)
  default     = []
}

variable "enable_dns_endpoint" {
  type    = bool
}
