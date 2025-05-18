# terraform {
#   required_providers {
#     google = {
#       source = "hashicorp/google"
#       version = "6.12.0"
#     }
#   }
# }


# terraform {
#   required_version = ">= 1.6.1"
#   required_providers {
#     google = {
#       source  = "hashicorp/google"
#       version = ">= 3.0.0,  >= 4.0.0"
#     }
#   }
# }


terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      # version = "~>3.0, >= 4.0.0, ~> 4.0, < 5.0.0"
      version = "~>4.0"   # Ensure consistency with module constraints
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~>4.0"  # Add google-beta for project_services_api module
    }
    # random = {
    #   source  = "hashicorp/random"
    #   version = ">= 2.2.0, < 4.0.0"  # Add version constraint for random provider
    # }
  }

  required_version = ">= 0.13"
}



# terraform {
#   required_version = ">= 1.6.1"
#   required_providers {
#     google = {
#       source  = "hashicorp/google"
#       version = ">= 4.0"
#     }
#     google-beta = {
#       source  = "hashicorp/google-beta"
#       version = ">= 4.0"
#     }
#   }
#   provider_meta "google" {
#     module_name = "blueprints/terraform/terraform-google-project-factory:project_services/v13.0.0"
#   }
#   provider_meta "google-beta" {
#     module_name = "blueprints/terraform/terraform-google-project-factory:project_services/v13.0.0"
#   }
# }