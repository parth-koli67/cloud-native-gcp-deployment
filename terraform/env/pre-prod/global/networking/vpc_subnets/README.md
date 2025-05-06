# Project Network and Subnetwork Module

This module makes it easy to create Network and Subnetwork for the GCP Network.

- Network (Virtual Private Cloud)
- Subnetwork (Subnets)

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| google | ~> 3.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cloud_dns"></a> [vpc](#module\_cloud_dns_) | ../../../../modules/networking/vpc | n/a |
| <a name="module_cloud_dns"></a> [subnet](#module\_cloud_dns_) | ../../../../modules/networking/subnets | n/a |


## Permissions

In order to execute this module you must have a Service Account with the
following project roles:

- Compute Admin [roles/compute.admin](https://cloud.google.com/nat/docs/using-nat#iam_permissions) on the project.
- Compute Network Admin [roles/compute.networkAdmin](https://cloud.google.com/nat/docs/using-nat#iam_permissions) on the project.

## Enable APIs

In order to operate with the Service Account you must activate the following APIs on the project where the Service Account was created:

- Compute Engine API - `compute.googleapis.com`

## Usage
Basic usage of this module is as follows:

* Network

```hcl
module "vpc" {
  source                  = "../../../../modules/networking/vpc"
  for_each                = var.vpc_config
  project_id              = var.project_id
  network_name            = each.value.network_name
  routing_mode            = each.value.routing_mode
  description             = each.value.description
  shared_vpc_host         = each.value.shared_vpc_host
  auto_create_subnetworks = each.value.auto_create_subnetworks
}
```

* Subnetwork

```hcl
module "subnets" {
  source           = "../../../../modules/networking/subnets"
  project_id       = var.project_id
  network_name     = local.first_vpc_name
  subnets          = var.subnets
  secondary_ranges = var.secondary_ranges
}
```

* Provide the variables values to the modules from terraform.tfvars file.

```hcl
project_id = "project_id"
region     = "region name"
vpc_name   = "vpc name"
subnets = [
  {
    subnet_name           = "subnet_name"
    subnet_ip             = "subnet_ip range"
    subnet_region         = "region name"
    subnet_private_access = "true"
    subnet_flow_logs      = "false"
  },
]
```
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | An optional description of this resource. The resource must be recreated to modify this field. | `string` | `"This VPC network will be used for dev Project"` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The ID of the project where this VPC will be created | `any` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The Region to deploy all resources | `any` | n/a | yes |
| <a name="input_routing_mode"></a> [routing\_mode](#input\_routing\_mode) | The network routing mode (default 'GLOBAL') | `string` | `"GLOBAL"` | no |
| <a name="input_secondary_ranges"></a> [secondary\_ranges](#input\_secondary\_ranges) | Secondary ranges that will be used in some of the subnets | `map(list(object({ range_name = string, ip_cidr_range = string })))` | `{}` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | The list of subnets being created | `list(map(string))` | n/a | yes |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | The VPC name to be created | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_network_name"></a> [network\_name](#output\_network\_name) | The name of the VPC being created |
| <a name="output_project_id"></a> [project\_id](#output\_project\_id) | VPC project id |
| <a name="output_subnets_ips"></a> [subnets\_ips](#output\_subnets\_ips) | The IPs and CIDRs of the subnets being created |
| <a name="output_subnets_names"></a> [subnets\_names](#output\_subnets\_names) | The names of the subnets being created |
| <a name="output_subnets_regions"></a> [subnets\_regions](#output\_subnets\_regions) | The region where the subnets will be created |

* Then perform the following commands in the directory:

   `terraform init` to get the plugins

   `terraform plan` to see the infrastructure plan

   `terraform apply` to apply the infrastructure build

   `terraform destroy` to destroy the built infrastructure
