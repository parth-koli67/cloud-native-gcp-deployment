/******************************************
  Providers Variables
 *****************************************/

variable "project_id" {
  description = "Existing Base project"
  type        = string
}

variable "terraform_owner_email" {
  description = "Email of the service account that will be used to create the project."
  type        = string
}

variable "region" {
  description = "The region to create the project in."
  type        = string
}



/******************************************
  service_account variables
 /*****************************************/

variable "service_account_terraform" {
  description = "Terraform Resource Deployment Service Account to add the IAM policies/bindings"
}


/******************************************
        Service API variables
 *****************************************/

variable "project_services_api" {
  type = map(
    object(
      {
        project_id                 = string
        activate_apis              = list(string)
        disable_dependent_services = bool
        disable_services_on_destroy = bool
      }
    )
  )
  default = {}
}



/*******************
  IAM Binding
 *******************/
variable "iam_bindings_config" {
  default = {}
}

