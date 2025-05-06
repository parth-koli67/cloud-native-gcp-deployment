/******************************************
          Artifactory Repository Variable
 *****************************************/

variable "project_id" {
  type = string
}

variable "repo" {
  description = "The details of the Cloud Storage Buckets."
  type = map(object({
    repo_name   = string,
    region      = string,
    format      = string,
    description = string,
    labels      = map(string),
  }))
}
