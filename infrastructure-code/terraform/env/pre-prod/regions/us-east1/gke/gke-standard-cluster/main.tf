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

module "gke_private_cluster" {
  source                              = "../../../../../modules/terraform-google-kubernetes-engine/gke_private_cluster"
  project_id                          = var.project_id
  network_project_id                  = var.network_project_id
  name                                = var.app_name
  region                              = var.region
  network                             = var.network
  gke_subnetwork                      = var.gke_subnetwork
  ip_range_pods                       = var.ip_range_pods
  ip_range_services                   = var.ip_range_services
  regional                            = var.regional
  zones                               = var.zones
  http_load_balancing                 = var.http_load_balancing
  enable_private_endpoint             = var.enable_private_endpoint
  enable_private_nodes                = var.enable_private_nodes
  enable_gateway_api                  = var.enable_gateway_api
  master_ipv4_cidr_block              = var.master_ipv4_cidr_block
  enable_binary_authorization         = var.enable_binary_authorization
  remove_default_node_pool            = var.remove_default_node_pool
  service_account                     = var.service_account
  kubernetes_version                  = var.gke_cluster_master_version
  cluster_resource_labels             = var.node_labels
  workload_identity_pool              = "${var.project_id}.svc.id.goog"
  master_authorized_networks          = var.master_authorized_networks
  enable_workload_identity            = var.enable_workload_identity
  enable_cost_allocation              = var.enable_cost_allocation
  enable_dns_endpoint                  = var.enable_dns_endpoint
  gke_backup_agent_config             = var.gke_backup_agent_config
  dns_cache_config                    = var.dns_cache_config
  maintenance                         = var.maintenance
  node_pools_tags                     = var.node_pools_tags
  release_channel                     = var.release_channel
  enable_security_posture             = var.enable_security_posture
  security_posture_mode               = var.security_posture_mode
  security_posture_vulnerability_mode = var.security_posture_vulnerability_mode
  
}

module "gke_node_pool" {
  source                         = "../../../../../modules/terraform-google-kubernetes-engine/gke_node_pool"
  project_id                     = var.project_id
  for_each                       = var.node_pools
  gke_cluster_name               = module.gke_private_cluster.name
  node_pool_name                 = each.value.app_name
  region                         = each.value.region
  regional                       = each.value.regional
  zones                          = each.value.zones
  gke_cluster_min_master_version = each.value.gke_cluster_min_master_version
  image_type                     = each.value.image_type
  machine_type                   = each.value.machine_type
  preemptible                    = each.value.preemptible
  enable_secure_boot             = each.value.enable_secure_boot
  auto_upgrade                   = each.value.auto_upgrade
  auto_repair                    = each.value.auto_repair
  max_pods_per_node              = each.value.max_pods_per_node
  node_count                     = each.value.node_count
  local_ssd_count                = each.value.local_ssd_count
  enable_autoscaling             = each.value.enable_autoscaling
  min_node_count                 = each.value.min_node_count
  max_node_count                 = each.value.max_node_count
  max_surge                      = each.value.max_surge
  labels                         = each.value.labels
  disk_size_gb                   = each.value.disk_size_gb
  disk_type                      = each.value.disk_type
  service_account                = each.value.service_account
  metadata                       = each.value.metadata
  network_tags                   = each.value.network_tags
  create_pod_range               = each.value.create_pod_range
  nodepool_pod_range             = each.value.nodepool_pod_range
  enable_private_nodes           = each.value.enable_private_nodes
  pod_ipv4_cidr_block            = each.value.nodepool_pod_cidr_range
}
