# Terraform Google Kubernetes Engine Module

This example illustrates how to create a private GKE cluster.

## Compatibility

This module is meant for use with Terraform v1.5.3 and tested using Terraform 1.0+. If you find incompatibilities using Terraform >=0.13, please open an issue. If you haven't [upgraded](https://www.terraform.io/language/upgrade-guides/0-13)

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 3.3 |

## Usage

Basic usage of the module as follows:

```
module "gke_private_cluster" {
  source                      = "../../../../../modules/google_kubernetes_engine/gke_private_cluster/"
  project_id                  = var.project_id
  network_project_id          = var.network_project_id
  name                        = var.app_name
  region                      = var.region
  network                     = var.network
  gke_subnetwork              = var.gke_subnetwork
  ip_range_pods               = var.ip_range_pods   
  ip_range_services           = var.ip_range_services 
  regional                    = var.regional
  zones                       = var.zones
  http_load_balancing         = var.http_load_balancing
  enable_private_endpoint     = var.enable_private_endpoint
  enable_private_nodes        = var.enable_private_nodes
  enable_gateway_api          = var.enable_gateway_api
  master_ipv4_cidr_block      = var.master_ipv4_cidr_block
  enable_binary_authorization = var.enable_binary_authorization
  remove_default_node_pool    = var.remove_default_node_pool
  service_account             = var.service_account
  kubernetes_version          = var.gke_cluster_master_version #GKE version can be upgraded
  cluster_resource_labels     = var.node_labels
  workload_identity_pool      = "${var.project_id}.svc.id.goog"
  master_authorized_networks  = var.master_authorized_networks
  enable_workload_identity    = var.enable_workload_identity
  enable_cost_allocation      = var.enable_cost_allocation
  gke_backup_agent_config     = var.gke_backup_agent_config
  maintenance                   = var.maintenance
  release_channel             =  var.release_channel 
  enable_security_posture     = var.enable_security_posture
  security_posture_mode       = var.security_posture_mode
  security_posture_vulnerability_mode = var.security_posture_vulnerability_mode
}

module "gke_node_pool" {
  source                         = "../../../../../modules/google_kubernetes_engine/gke_node_pool/"
  project_id                     = var.project_id
  for_each                       = var.node_pools 
  gke_cluster_name               = module.gke_private_cluster.name
  node_pool_name                 = each.value.app_name
  region                         = each.value.region
  regional                       = each.value.regional
  zones                          = module.gke_private_cluster.zones
  gke_cluster_min_master_version = each.value.gke_cluster_min_master_version
  image_type                     = each.value.image_type
  machine_type                   = each.value.machine_type
  preemptible                    = each.value.preemptible
  auto_upgrade                   = each.value.auto_upgrade
  auto_repair                    = each.value.auto_repair
  max_pods_per_node              = each.value.max_pods_per_node
  node_count                     = each.value.node_count
  local_ssd_count                = each.value.local_ssd_count
  enable_autoscaling             = each.value.enable_autoscaling
  enable_integrity_monitoring    = each.value.enable_integrity_monitoring
  enable_secure_boot             = each.value.enable_secure_boot
  min_node_count                 = each.value.min_node_count
  max_node_count                 = each.value.max_node_count
  max_surge                      = each.value.max_surge
  labels                         = each.value.labels
  disk_size_gb                   = each.value.disk_size_gb
  disk_type                      = each.value.disk_type
  service_account                = each.value.service_account
  metadata                       = each.value.metadata
}

```

To provision this example, run the following from within this directory:
- `terraform init` to get the plugins
- `terraform plan` to see the infrastructure plan
- `terraform apply` to apply the infrastructure build
- `terraform destroy` to destroy the built infrastructure
## Terraform files
* * *
- Inside each subfolder the terraform files are present and these files are responsible for creating resources in GCP projects.
- Details of each file is given in the table below
​

| FILE NAME | DESCRIPTION | 
|----------- | --------------------------------------------------------------------------------------------|
|backend.tf | To specify remote backend of GCS to store tfstate files|
|main.tf | This file defines modules for the resource provisioning |
|output.tf | This file defines the outputs of different resources provisioned by terraform |
|provider.tf | This file specifies the google provider to be used by the terraform module |
|variables.tf | This file contains the declaration of variables for different resources |
|versions.tf | This file defines the version constraints for various modules and plugins used in terraform configuration |
|mum.tfvars | This file stores the input variables values that are used for provisioning resources in mMmbai region |
|del.tfvars | This file stores the input variables values that are used for provisioning resources in Delhi region |
|cloudbuild-plan.yaml | This file contains the information regarding cloudbuild trigger to plan the provisioning of resource |
|cloudbuild-apply.yaml | This file contains the information regarding cloudbuild trigger to apply the provisioning of resource |


## Backend information
***
- We are using remote backend to save terraform state file. The tf state file is stored in GCS bucket hosted in  project
​
- The GCS bucket name is bucketname.

## Relevance of multiple tfvars (Select the region for GCP resources)
* * *
​
Update input variables in below files based on the region.
```diff
+ We are using two different tfvars file based on the region we want to deploy resources. There are two files mum (Mumbai) and del(delhi)
```
​
| File | Environment | 
|------|-------------|
| mum.tfvars | To create GCP resources in Mumbai region |
| del.tfvars | To create GCP resources in Delhi region |

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs Variables

- Cluster Variables:

| Name                           | Description | Type | 
|--------------------------------|-------------|------|
| `project_id` | The ID of the project where resources will be created. | `string` |
| `network_project_id` | The ID of the project containing the network. | `string` |
| `name` | Name of the application. | `string` |
| `region` | Region for the resources. | `string` |
| `network` | ID or name of the VPC network. | `string` |
| `gke_subnetwork` | ID or name of the GKE subnetwork. | `string` |
| `ip_range_pods` | IP range for pods. | `string` |
| `ip_range_services` | IP range for services. | `string` |
| `regional` | Whether the cluster is regional. | `bool` |
| `zones` | List of availability zones. | `list(string)` |
| `http_load_balancing` | Whether to enable HTTP load balancing. | `bool` |
| `enable_private_endpoint` | Whether to enable private endpoint. | `bool` |
| `enable_private_nodes` | Whether to enable private nodes. | `bool` |
| `enable_gateway_api` | Whether to enable gateway API. | `bool` |
| `enable_cost_allocation` | Whether to enable cost allocation . | `bool` |
| `gke_backup_agent_config` | Backup for GKE allows you to back up and restore GKE workloads. | `bool` |  
| `master_ipv4_cidr_block` | IP range for the master's CIDR block. | `string` |
| `enable_binary_authorization` | Whether to enable binary authorization. | `bool` |
| `remove_default_node_pool` | Whether to remove the default node pool. | `bool` |
| `service_account` | Service account information. | `string` |
| `gke_cluster_master_version` | Kubernetes version for the GKE cluster. | `string` |
| `node_labels` | Labels for the cluster resources. | `map(string)` |
| `workload_identity_pool` | Workload identity pool for authentication. | `string` |
| `master_authorized_networks` | List of authorized networks for the master. | `list(object({ cidr_block = string, display_name = string }))` |
| `release_channel` | The release channel of this cluster. Accepted values are `UNSPECIFIED`, `RAPID`, `REGULAR` and `STABLE` | `string` |
| `security_posture_mode` | Sets the mode of the Kubernetes security posture API's off-cluster features. Available options include DISABLED and BASIC | `string` |
| `security_posture_vulnerability_mode` | Sets the mode of the Kubernetes security posture API's workload vulnerability scanning. Available options include VULNERABILITY_DISABLED, VULNERABILITY_BASIC and VULNERABILITY_ENTERPRISE | `string` |

- Nodepool Variables:

| Name                           | Description | Type | 
|--------------------------------|-------------|------|

| `app_name` | Name of the application. | `string` |
| `region` | Region for the resources. | `string` |
| `regional` | Whether the cluster is regional. | `bool` |
| `zones` | List of availability zones. | `list(string)` |
| `gke_cluster_min_master_version` | Minimum master version for GKE cluster. | `string` |
| `image_type` | Type of image for nodes. | `string` |
| `machine_type` | Type of the machine for nodes. | `string` |
| `preemptible` | Whether nodes are preemptible. | `bool` |
| `auto_upgrade` | Whether nodes automatically upgrade. | `bool` |
| `auto_repair` | Whether nodes automatically repair. | `bool` |
| `max_pods_per_node` | Maximum pods allowed per node. | `number` |
| `node_count` | Total number of nodes. | `number` |
| `initial_node_count` | Initial number of nodes. | `number` |
| `local_ssd_count` | Number of local SSDs per node. | `number` |
| `enable_autoscaling` | Whether to enable node autoscaling. | `bool` |
| `min_node_count` | Minimum number of nodes in autoscaling. | `number` |
| `max_node_count` | Maximum number of nodes in autoscaling. | `number` |
| `labels` | Labels for the nodes. | `map(string)` |
| `disk_size_gb` | Disk size in GB for each node. | `number` |
| `disk_type` | Type of disk for nodes. | `string` |
| `max_surge` | Maximum number of nodes that can be added during an upgrade. | `number` |
| `max_unavailable` | Maximum number of nodes that can be unavailable during an upgrade. | `number` |
| `enable_secure_boot` | Whether to enable secure boot. | `bool` |
| `enable_integrity_monitoring` | Whether to enable integrity monitoring. | `bool` |
| `service_account` | Service account for the nodes. | `string` |

### Service Account

User or service account credentials with the following roles must be used to provision the resources of this module:

- `roles/container.admin`
- `roles/compute.instanceAdmin.v1`

### APIs

A project with the following APIs enabled must be used to host the
resources of this module:

- `container.googleapis.com`


## Terraform Plugins

- [Terraform](https://www.terraform.io/downloads) >= 0.13.0
- [terraform-provider-google plugin](https://github.com/hashicorp/terraform-provider-google) < 5.0, >= 2.12
- [terraform-provider-google-beta plugin](https://github.com/hashicorp/terraform-provider-google-beta) < 5.0, >= 3.45

