# HTTPS Load Balancer

This module allows creation of Global HTTPS LB.
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | > 0.13 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 3.53, < 5.0 |
| <a name="requirement_google-beta"></a> [google-beta](#requirement\_google-beta) | >= 4.40, < 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | >= 3.53, < 5.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_bucket-backends"></a> [bucket-backends](#module\_bucket-backends) | ../../../modules/loadbalancer/cdn_backend_bucket | n/a |
| <a name="module_loadbalancer"></a> [loadbalancer](#module\_loadbalancer) | ../../../modules/loadbalancer/external_https_lb | n/a |

## Resources

| Name | Type |
|------|------|
| [google_compute_managed_ssl_certificate.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_managed_ssl_certificate) | resource |
| [google_compute_url_map.urlmap](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_url_map) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_backend_services"></a> [backend\_services](#input\_backend\_services) | list of Backend services for the LB. | `any` | n/a | yes |
| <a name="input_bucket-backends"></a> [bucket-backends](#input\_bucket-backends) | CDN backends for the GCS bucket name. | `any` | n/a | yes |
| <a name="input_domains"></a> [domains](#input\_domains) | List of domains for certificate | `any` | n/a | yes |
| <a name="input_gcp_cert_name"></a> [gcp\_cert\_name](#input\_gcp\_cert\_name) | GCP Managed certificate name | `any` | n/a | yes |
| <a name="input_global_static_ip"></a> [global\_static\_ip](#input\_global\_static\_ip) | Name of global static IP created. | `any` | n/a | yes |
| <a name="input_managed_ssl_certificate_domains"></a> [managed\_ssl\_certificate\_domains](#input\_managed\_ssl\_certificate\_domains) | Create Google-managed SSL certificates for specified domains. Requires `ssl` to be set to `true` and `use_ssl_certificates` set to `false`. | `list(string)` | `[]` | no |
| <a name="input_name"></a> [name](#input\_name) | name used to generate the LB. | `string` | n/a | yes |
| <a name="input_network_name"></a> [network\_name](#input\_network\_name) | The name of the network being created | `string` | n/a | yes |
| <a name="input_port_specification"></a> [port\_specification](#input\_port\_specification) | Port specification for tcp health check can be - USE\_FIXED\_PORT, USE\_NAMED\_PORT, USE\_SERVING\_PORT | `string` | `"USE_SERVING_PORT"` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The ID of the project where this VPC will be created | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | GCP region where the resource will be created | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket-backend-id"></a> [bucket-backend-id](#output\_bucket-backend-id) | n/a |
| <a name="output_bucket-backend-self-link"></a> [bucket-backend-self-link](#output\_bucket-backend-self-link) | n/a |
| <a name="output_load-balancer-ip"></a> [load-balancer-ip](#output\_load-balancer-ip) | n/a |


### Flow of Terraform commands to follow
Perform the following commands on the root folder:

- `terraform init` to get the plugins
- `terraform plan` to see the infrastructure plan
- `terraform apply` to apply the infrastructure build
- `terraform destroy` to destroy the built infrastructure

### The Terraform resources will consists of following structure
```
├── README.md                 // Description of the module and what it should be used for.
├── main.tf                   // The primary entrypoint for terraform resources.
├── variables.tf              // It contains the declarations for variables.
├── outputs.tf                // It contains the declarations for outputs.
├── providers.tf              // To specify infrastructure vendors.
├── versions.tf               // To specify terraform versions.
├── backend.tf                // To create terraform backend state configuration.
├── terraform.tfvars   // The file to pass the terraform variables values.
```
