# Google Cloud Armor
This module makes it easy to create Google Cloud Armor and help protect your applications and websites against denial of service and web attacks.


## Features 

Named IP Lists
IP-based and geo-based access control
Pre-configured WAF rules

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.3 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 5.35.0 |

## Providers

| Name | Version |
|------|---------|
| google | ~> 5.35.0 |

## Usage
Basic usage of this module is as follows:

* Cloud Armor Module

```hcl
module "upland-pre-prod-security-policy" {
  source = "../../../../../modules/networking/cloud_armo"
  project = var.project
  name = var.name
  ip_ranges_rules = var.ip_ranges_rules
  owasp_rules = var.owasp_rules
  countries_rules = var.countries_rules
  throttle_rules  = var.throttle_rules
}
```

* Provide the variables values to the modules from terraform.tfvars file.

```hcl
  project = "PROJECT_ID"
  name = "POLICY_NAME"
  ip_ranges_rules = [XXX]
  owasp_rules = [XXX]
  countries_rules [XXX]
  throttle_rules [XXX]
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_countries_rules"></a> [countries\_rules](#input\_countries\_rules) | n/a | <pre>map(object({<br>        action                              = string<br>        priority                            = string<br>        description                         = string<br>        preview                             = bool<br>        expression                          = string<br>        })<br>    )</pre> | n/a | yes |
| <a name="input_ip_ranges_rules"></a> [ip\_ranges\_rules](#input\_ip\_ranges\_rules) | The rules for configuring set of IP addresses or ranges | <pre>list(object({<br>    action          = string<br>    priority        = string<br>    versioned_expr  = string<br>    description     = string<br>    preview         = bool<br>    src_ip_ranges   = list(string)<br>  }))</pre> | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the security policy | `string` | n/a | yes |
| <a name="input_owasp_rules"></a> [owasp\_rules](#input\_owasp\_rules) | n/a | <pre>map(object({<br> action			= string<br> priority		= string<br> description	        = string<br> preview		= bool<br> expression		= string<br> })<br> )</pre> | n/a | yes |
| <a name="input_throttle_rules"></a> [throttle\_rules](#input\throttle\_rules) | Rules to limit access based on rate of access | <pre>map(object({<br> action						= string<br> priority					= string<br> description					= string<br> preview					= bool<br> versioned_expr					= string<br> src_ip_ranges_throttle				= list(string) <br> conform_action					= string <br> exceed_action					= string <br> count						= number <br> interval_sec					= number <br> })<br> ) </pre> | null | yes |
| <a name="input_project"></a> [project](#input\_project) | The project in which the resource belongs. If it is not provided, the provider project is used | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | n/a |

* Then perform the following commands in the directory:

   `terraform init` to get the plugins

   `terraform plan` to see the infrastructure plan

   `terraform apply` to apply the infrastructure build

   `terraform destroy` to destroy the built infrastructure