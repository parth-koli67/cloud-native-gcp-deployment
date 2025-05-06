

variable "project_id" {
  type = string
  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{4,28}[a-z0-9]$", var.project_id))
    error_message = "The project_id must be a string of alphanumeric or hyphens, between 6 and 3o characters in length."
  }
  description = "The GCP project identifier where the secret will be created."
}

variable "id" {
  type = string
  validation {
    condition     = can(regex("^[a-zA-Z0-9_-]{1,255}$", var.id))
    error_message = "The id must be a string of alphanumeric, hyphen, and underscore characters, and upto 255 characters in length."
  }
  description = "The secret identifier to create; this value must be unique within the project."
}

variable "replication_locations" {
  type        = list(string)
  default     = []
  description = <<EOD
An optional list of replication locations for the secret. If the value is an
empty list (default) then an automatic replication policy will be applied. Use
this if you must have replication constrained to specific locations.

E.g. to use automatic replication policy (default)
replication_locations = []

E.g. to force secrets to be replicated only in us-central1 and us-west1 regions:
replication_locations = [ "us-central1", "us-west1" ]
EOD
}

# variable "secret" {
#   type = string
#   validation {
#     condition     = length(var.secret) > 0
#     error_message = "The secret must be a string that contains at least 1 character."
#   }
#   description = "The secret payload to store in Secret Manager. Binary values should be base64 encoded before use."
# }

variable "labels" {
  type        = map(string)
  default     = {}
  description = "An optional map of label key:value pairs to assign to the secret resources.Default is an empty map."
}