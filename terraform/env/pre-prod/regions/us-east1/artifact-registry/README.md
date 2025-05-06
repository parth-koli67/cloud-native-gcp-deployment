
# Artifact Registry Module

This module allows us to create Artifact Registry.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.6.1 |
| google | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| google | ~> 3.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cloud_dns"></a> [artifact-registry](#module\_cloud_dns_) | ../../../../modules/artifact-registry | n/a |

## Enable APIs
In order to operate with the Service Account you must activate the following APIs on the project where the Service Account was created:

Artifact Registry API - [artifactregistry.googleapis.com](https://artifactregistry.googleapis.com)

## Permissions

In order to execute this module you must have a Service Account with the
following project roles:

- [roles/artifactregistry.admin](https://cloud.google.com/compute/docs/access/iam)
- [roles/artifactregistry.repoAdmin](https://cloud.google.com/compute/docs/access/iam)
- [roles/artifactregistry.writer](https://cloud.google.com/compute/docs/access/iam)
- [roles/artifactregistry.reader](https://cloud.google.com/compute/docs/access/iam)


## Usage

Basic usage of this module is as follows:

```
#Artifact Repository Module
module "artifact_registry" {
  source      = "../../../../modules/artifact-registry"
  region_name = var.region
  project_id  = var.project_id
  repo_id     = var.repo
  format_type = var.format
  labels      = var.ar_labels
  description = var.description
}
```

* Provide the variables values to the modules from terraform.tfvars file.

```hcl
project_id       = "<PROJECT_ID>"

repo = {
  repo_01 = {
    repo_name   = "REPO_NAME"
    region      =  "<REGION>"
    format      = "Docker"
    description = "description"
    labels = {
      key = "value",
    }
  }
}
```

* Then perform the following commands on the root folder:

- `terraform init` to get the plugins
- `terraform plan` to see the infrastructure plan
- `terraform apply` to apply the infrastructure build
- `terraform destroy` to destroy the built infrastructure

## Input Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| project\_id | The ID of the project where it will be created | `string` | n/a | yes |
| repo | The Name of the Artifact Registry | <pre>map(object({<br>repo_name= string,<br>region = string,<br> format= string,<br> description = string,<br>labels= map(string), }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| artifact_registry_details | The details of the created Artifact Registry. |

## Permissions

- Artifact Registry Admin: `roles/artifactregistry.admin`
- (optional) roles needed to grant optional IAM roles at the project or organizational level

## Terraform plugins

- [Terraform](https://www.terraform.io/downloads.html) >= 0.13
- [terraform-provider-google](https://github.com/terraform-providers/terraform-provider-google) plugin >= 3.53, < 5.0