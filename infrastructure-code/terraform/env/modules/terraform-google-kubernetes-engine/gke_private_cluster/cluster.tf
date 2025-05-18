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

// This file was automatically generated from a template in ./autogen/main

/******************************************
  Create Container Cluster
 *****************************************/

#########
# Locals
#########
locals {
   enable_workload_identity = var.enable_workload_identity ? [true] : [] 
 }



resource "google_container_cluster" "primary" {
  provider = google-beta

  name            = var.name
  description     = var.description
  project         = var.project_id
  resource_labels = var.cluster_resource_labels

  location              = local.location
  node_locations        = local.node_locations
  cluster_ipv4_cidr     = var.cluster_ipv4_cidr
  enable_shielded_nodes = var.enable_shielded_nodes
  network               = "projects/${local.network_project_id}/global/networks/${var.network}"

  
  
  #binary_authorization = var.enable_binary_authorization
  dynamic "binary_authorization" {
    for_each = var.enable_binary_authorization ? [var.enable_binary_authorization] : []
    content {
      evaluation_mode = "PROJECT_SINGLETON_POLICY_ENFORCE"
    }
  }

  # dynamic "control_plane_endpoints_config" {
  #   for_each = var.access_config.dns_access == true ? [""] : []
  #   content {
  #     dns_endpoint_config {
  #       allow_external_traffic = true
  #     }
  #   }
  # }

  control_plane_endpoints_config {
  dynamic "dns_endpoint_config" {
    for_each = var.enable_dns_endpoint ? [1] : []
    
    content {
      allow_external_traffic = true
    }
  }
}

  dynamic "gateway_api_config" {
    for_each = var.enable_gateway_api ? [1] : []
    content {
      channel = "CHANNEL_STANDARD"
    }
  }

  dynamic "release_channel" {
    for_each = local.release_channel

    content {
      channel = release_channel.value.channel
    }
  }

  dynamic "network_policy" {
    for_each = local.cluster_network_policy

    content {
      enabled  = network_policy.value.enabled
      provider = network_policy.value.provider
    }
  }

  dynamic "authenticator_groups_config" {
    for_each = var.google_security_group == null ? [] : tolist([var.google_security_group])
    content {
      security_group = var.google_security_group
    }
  }

  dynamic "workload_identity_config" {
    for_each = var.workload_identity_pool == null ? [] : tolist([var.workload_identity_pool])
    content {
      workload_pool = var.workload_identity_pool
      # identity_namespace = var.workload_identity_pool
    }
  }

  dynamic "authenticator_groups_config" {
    for_each = local.cluster_authenticator_security_group
    content {
      security_group = authenticator_groups_config.value.security_group
    }
  }

  subnetwork = "projects/${local.network_project_id}/regions/${var.region}/subnetworks/${var.gke_subnetwork}"

  min_master_version = local.master_version

  logging_service    = var.logging_service
  monitoring_service = var.monitoring_service


  # default_max_pods_per_node = var.default_max_pods_per_node

  dynamic "master_authorized_networks_config" {
    for_each = local.master_authorized_networks_config
    content {
      dynamic "cidr_blocks" {
        for_each = master_authorized_networks_config.value.cidr_blocks
        content {
          cidr_block   = lookup(cidr_blocks.value, "cidr_block", "")
          display_name = lookup(cidr_blocks.value, "display_name", "")
        }
      }
    }
  }

  master_auth {

    client_certificate_config {
      issue_client_certificate = var.issue_client_certificate
    }
  }

  addons_config {

    gke_backup_agent_config {
      enabled = var.gke_backup_agent_config
    }
    
    dns_cache_config {
      enabled = var.dns_cache_config
    }

    http_load_balancing {
      disabled = !var.http_load_balancing
    }

    horizontal_pod_autoscaling {
      disabled = !var.horizontal_pod_autoscaling
    }


    gcp_filestore_csi_driver_config {
      enabled = var.gcp_filestore_csi_driver
    }

    network_policy_config {
      disabled = !var.network_policy
    }
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = var.ip_range_pods
    services_secondary_range_name = var.ip_range_services
  }

  datapath_provider = var.datapath_provider

  maintenance_policy {
    # daily_maintenance_window {
    # start_time = var.maintenance_start_time
    # }
    recurring_window {
      start_time = var.maintenance["start_time"]
      end_time   = var.maintenance["end_time"]
      recurrence = var.maintenance["recurrence_frequency"]
    }
  }

  lifecycle {
    prevent_destroy = false
    ignore_changes = [node_pool,initial_node_count,maintenance_policy]
  }

  timeouts {
    create = "45m"
    update = "45m"
    delete = "45m"
  }

  ## Adding a default Nodepool
  node_pool {
    name               = "default-pool"
    initial_node_count = var.initial_node_count

    node_config {
      service_account = lookup(var.node_pools[0], "service_account", local.service_account)
      tags            = lookup(local.node_pools_tags, "all", [])
    }
  }
  
  dynamic "cost_management_config" {
    for_each = var.enable_cost_allocation ? [1] : []
    content {
      enabled = var.enable_cost_allocation
    }
  }

  dynamic "security_posture_config" {
   for_each = var.enable_security_posture ? [1] : []
   content{ 
    mode               = var.security_posture_mode
    vulnerability_mode = var.security_posture_vulnerability_mode
   }
  }


  dynamic "resource_usage_export_config" {
    for_each = var.resource_usage_export_dataset_id != "" ? [{
      enable_network_egress_metering       = var.enable_network_egress_export
      enable_resource_consumption_metering = var.enable_resource_consumption_export
      dataset_id                           = var.resource_usage_export_dataset_id
    }] : []

    content {
      enable_network_egress_metering       = resource_usage_export_config.value.enable_network_egress_metering
      enable_resource_consumption_metering = resource_usage_export_config.value.enable_resource_consumption_metering
      bigquery_destination {
        dataset_id = resource_usage_export_config.value.dataset_id
      }
    }
  }

  dynamic "private_cluster_config" {
    for_each = var.enable_private_nodes ? [{
      enable_private_nodes    = var.enable_private_nodes,
      enable_private_endpoint = var.enable_private_endpoint
      master_ipv4_cidr_block  = var.master_ipv4_cidr_block
    }] : []

    content {
      enable_private_endpoint = private_cluster_config.value.enable_private_endpoint
      enable_private_nodes    = private_cluster_config.value.enable_private_nodes
      master_ipv4_cidr_block  = private_cluster_config.value.master_ipv4_cidr_block
    }
  }

  remove_default_node_pool = var.remove_default_node_pool
}

resource "null_resource" "wait_for_cluster" {
  count = var.skip_provisioners ? 0 : 1

  triggers = {
    project_id = var.project_id
    name       = var.name
  }

  provisioner "local-exec" {
    command = "${path.module}/scripts/wait-for-cluster.sh ${self.triggers.project_id} ${self.triggers.name}"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "${path.module}/scripts/wait-for-cluster.sh ${self.triggers.project_id} ${self.triggers.name}"
  }

  depends_on = [
    google_container_cluster.primary,
    # google_container_node_pool.pools,
  ]
}
