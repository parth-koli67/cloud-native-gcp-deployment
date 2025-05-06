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

# /******************************************
#    GKE Cluster Details
# *****************************************/

# Global
project_id         = "personal-project-1-458808"
region             = "us-central1"
regional           = true
# zones              = ["us-central1-b"]
network_project_id = "personal-project-1-458808"
network            = "main-vpc"
gke_subnetwork     = "gke-pvt-us-est1-subnet"


# cluster configurations
app_name                    = "gke-std-cluster-01"
gke_cluster_master_version  = "1.32.2-gke.1297002"
master_ipv4_cidr_block      = "10.105.230.16/28"
http_load_balancing         = true
enable_private_endpoint     = true
enable_private_nodes        = true
enable_binary_authorization = true
remove_default_node_pool    = true
enable_gateway_api          = true
ip_range_pods               = "gke-pod-range"
ip_range_services           = "gke-svc-range"
enable_workload_identity    = true
gke_backup_agent_config     = false

enable_cost_allocation              = true
enable_dns_endpoint                  = true
enable_security_posture             = true #in order to enable , mention true here and add other values.
security_posture_mode               = "BASIC"
security_posture_vulnerability_mode = "VULNERABILITY_BASIC"
release_channel                     = "REGULAR"
master_authorized_networks = [
  { cidr_block = "10.105.230.0/28", display_name = "mgmt-subnet" },
]
maintenance = {
  start_time           = "2021-08-01T19:30:00Z"
  end_time             = "2031-08-01T23:30:00Z"
  recurrence_frequency = "FREQ=DAILY"
}

node_labels = {
  env        = "pre-prod"
  created_by = "terraform"
}
node_pools_tags = {
  all = [""]
}
service_account = "gke-sa@personal-project-1-458808.iam.gserviceaccount.com"

# /******************************************
#    Nodepool Configuration & Details
# *****************************************/ 
node_pools = {
  "application-node-pool" = {
    auto_repair                    = true
    auto_upgrade                   = true
    disk_size_gb                   = 20
    disk_type                      = "pd-standard"
    network_tags                   = ["allow-hc-access"]
    nodepool_pod_range             = ""
    enable_private_nodes           = true
    enable_autoscaling             = true
    enable_integrity_monitoring    = true
    enable_secure_boot             = true
    gke_cluster_min_master_version = "1.32.2-gke.1297002"
    image_type                     = "COS_CONTAINERD"
    labels = {
      env     = "pre-prod"
      purpose = "k8s-linux-pods"
      region  = "us-central1"

    }
    local_ssd_count   = 0
    machine_type      = "e2-medium"
    max_node_count    = 3
    max_pods_per_node = 110
    max_surge         = 2
    max_unavailable   = 1
    min_node_count    = 1

    node_count                  = 1
    initial_node_count          = 1
    app_name                    = "application-node-pool"
    preemptible                 = false
    region                      = "us-central1"
    regional                    = true
    service_account             = "gke-sa@personal-project-1-458808.iam.gserviceaccount.com"
    workload_node_metadata_mode = "GKE_METADATA"
    zones                       = ["us-central1-b"]
    metadata = {
      disable-legacy-endpoints = "true"
    }
  },
}
